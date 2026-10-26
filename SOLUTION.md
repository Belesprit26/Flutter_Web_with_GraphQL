# Solution

## 1. Overview

A customer picks one or two services, a time slot and a saved card, and
confirms. The app places a temporary hold and opens `/orders/<id>`, whose
timeline shows the hold as pending, then placed (or declined) when the simulated
card provider answers about 2.5 seconds later.

One Flutter codebase runs on web, iOS and Android. GraphQL is typed end to end:
the schema and operations live in the repo, ferry generates the client types, and
an in-app server answers through a custom `Link`, so there's no backend to run.
Never creating two orders for one intended checkout has five layers of protection
and an end-to-end test.

## 2. Architecture

A pub workspace of five packages. The boundaries are real dependencies:

```
checkout_app ──▶ checkout_feature ──▶ graphql_api
     │                  └──▶ design_system
     ├──▶ local_backend     (only the app wires the server in)
     └──▶ design_system
```

- **`local_backend`** is the stand-in backend. It's pure Dart and knows nothing
  about the client.
- **`graphql_api`** holds the contract. It's pure Dart and never knows whether
  the server behind its `Link` is local.
- **`checkout_feature`** is split into domain, data and presentation. A test
  fails the build if a layer imports what it shouldn't.
- **`checkout_app`** is thin: startup, get_it wiring (one file per layer), the
  router and config.

State follows Flutter's app-architecture guide: `ChangeNotifier` view models and
`Command`s. Each page gets a fresh view model from its route. There's one use case,
`PlaceOrderUseCase`, because that's where the logic is; plain reads go straight to
repositories. Repositories return a sealed `Result`, and data-layer exceptions are
mapped once into user-facing failures. Strict analysis (`strict-casts`,
`avoid_dynamic_calls`) keeps dynamic access out of app code.

## 3. Typed GraphQL without a backend

- **Schema** in `packages/graphql_api/lib/schema/schema.graphql`, with 6
  operations. Money is `Int` cents. An order's slot and card are id-less snapshot
  types, so ferry's normalised cache never merges them with live records.
- **Generated code is committed.** A fresh clone runs without build_runner, and
  `tool/check_codegen.sh` fails if the committed code is stale. The cost:
  ferry_generator caps the analyzer below 13, which holds the workspace on
  build_runner 2.15.1.
- **`LocalServerLink`** implements `gql_link`'s `Link`. It sends each root field
  to a resolver, reads the caller from an injected `currentUserId` (the stand-in
  for an auth header), and adds a configurable network delay. Resolvers return
  maps, which is the only place maps exist.
- **Contract tests** run every operation through a real ferry client, link and
  server, and require the generated type. Dropping a field on the server fails
  the test with the field's name.
- **Pending, then placed.** The order page watches `OrderDetails` and keeps an
  `orderUpdated` subscription open until the order is final. The subscription
  sends the current state first, so a hold that settles before the page subscribes
  isn't missed, and its results land in ferry's cache, which re-emits the query.
- **A real endpoint** is one change: a different `Link` (e.g. AppSync) in
  `apps/checkout_app/lib/di/register_data.dart`.

## 4. Navigation, deep links and sign-in

go_router 17 with path URLs. Version 18 moved to the new standalone Material
package, an app-wide migration with no routing gain.

- **Routes.** `/services` is public. `/checkout?services=a,b&slot=<id>` and
  `/orders/:orderId` need sign-in. Anything else gets a not-found page.
- **Pure redirect policy.** A protected page visited while signed out goes to
  `/sign-in?from=<full location>`, query included, and comes back after sign-in.
  The policy is a pure, synchronous function, unit tested branch by branch.
- **No open redirects.** Only internal pages are accepted as `from`.
- **A Flutter web quirk.** Flutter web writes the sign-in URL back to the address
  bar decoded, so everything after `from=` is read as the return location. A slot
  survives a refresh on sign-in.
- **The selection lives in the URL,** so refreshes and shared links restore it.
- **Startup order.** The session is restored and the server has loaded its orders
  before `runApp`, so a signed-in refresh doesn't bounce through sign-in.
- **Simulated sign-in.** A demo user with a fixed id, or any name. Orders are
  scoped to their owner.
- **Hosting.** A release build needs a host that answers unknown paths with
  `index.html`. `tool/serve_web.dart` does that locally.

## 5. Avoiding duplicate financial outcomes

| # | Layer | What it stops |
|---|---|---|
| 1 | `Command.execute` drops a call while one is running | Double and triple clicks |
| 2 | Confirm button bound to `confirm.running` | Visible feedback; not relied on |
| 3 | Single-flight + a saved checkout attempt (`PlaceOrderUseCase`) | Concurrent calls, retries, refresh mid-confirm |
| 4 | Server idempotency in `createOrder` | Any replay of the same key |
| 5 | Checkout reads the attempt on load; success replaces the history entry | Back or forward into a finished checkout |

**The key belongs to the attempt, not the click.**
- It's minted when a checkout attempt starts, saved before the request goes out,
  and reused on every retry and after a reload.
- Two concurrent confirms for the same selection share one request.
- A failure with an unknown outcome (network, server error) keeps the key. A
  definite rejection (slot taken) returns the attempt to draft, so a changed
  selection gets a new key.

**Replay first, atomically.**
- The server looks up `(user, key)` before validating. The same request gets the
  original order with `replayed: true`; a different request gets
  `IDEMPOTENCY_KEY_REUSED`.
- The lookup, validation and insert run in one synchronous block, the in-process
  version of a unique index on `(user_id, idempotency_key)`.
- The key is stored on the order record, so the two are always saved together.

| Scenario | Result |
|---|---|
| Double-click confirm | Second click dropped (1, 2) |
| Confirm, then refresh before the answer | "Finishing your checkout…", same key replayed, same order (3, 4) |
| Network error, click again | Same key; one order (3, 4) |
| Slot taken, pick another | New key for the new selection (3) |
| Declined, "Try again" | Attempt abandoned; a new attempt (3) |
| Same key, different payload | `IDEMPOTENCY_KEY_REUSED` (4) |
| Back after success | "Already placed" with a link (5) |
| Refresh the order page while pending | Pending holds are rescheduled on start; the page flips |

**Limitations**
- **Per-tab server.** The in-app server runs per browser tab, so two tabs
  submitting at the same instant aren't protected against each other. Records are
  one key per order, so tabs don't overwrite each other. A shared server with the
  unique index closes this.
- **Lost answer, then a changed selection.** If an answer is lost and the user
  changes the selection before retrying or reloading, the first order may exist
  too. A reload resumes first.
- **Unanswered holds** stay pending. The page says it's safe to leave; a real
  system would expire the hold on the server.
- **Data is per browser.**

## 6. Optional item: one meaningful test

[`duplicate_submission_test.dart`](packages/checkout_feature/test/duplicate_submission_test.dart)
runs the real use case, attempt store, ferry client, link and server. It covers
simultaneous confirms, a reload mid-confirm, a retry after a lost answer, a taken
slot, and a decline followed by "Try again".

I chose it because it's the requirement with money attached and it crosses every
layer. I checked it can fail: switching off single-flight, or minting a key per
click, breaks it.

The repo has 116 tests in total, including contract tests, the redirect policy
with open-redirect cases, the layer rules, and a journey test through the real
screens.

## 7. What I'd do next

**Cut for time:**
- the responsive two-column checkout, shared design-system widgets and a bundled
  font (the app has a minimal theme and a centred column);
- CI running `tool/test_all.sh` and `tool/check_codegen.sh`;
- a debug panel with the order count and attempt key;
- a live deploy;
- pruning server responses to the selection set;
- a DI registration test;
- an iOS simulator click-through (the iOS build compiles; Android was run by
  hand).

**For production:**
- an AppSync link with real auth;
- Postgres with a unique index on `(user_id, idempotency_key)`;
- real pre-authorisation, capture and void via the payment provider, with its
  webhook driving the subscription;
- server-side hold expiry;
- order history;
- the go_router 18 migration.

## 8. AI usage

**Tools.**
- **Planning:** Claude (claude.ai). I wrote the plan with it: architecture,
  phases, decision gates and a requirements checklist.
- **Implementation, review and debugging:** Claude Code.

Claude Code wrote most of the code. I made the decisions at each gate (schema
lock, client library, replay rules, URL state), reviewed every phase, edited the
decision log, and tested by hand in Chrome and on an Android emulator.

**Examples.**
- **Accepted, after checking.** Before any code, Claude Code checked the plan's
  package assumptions on pub.dev. ferry's generator pins an older analyzer, and
  go_router 18 had moved to a new Material package. I pinned go_router 17 and set
  the SDK floor accordingly. The first `pub get` resolved exactly the predicted
  versions.
- **Changed.**
  - The first contract test passed, but when Claude Code deliberately broke the
    server it hung instead of failing, so it was rewritten to stop on the first
    error.
  - The journey test stuck on "pending". Claude Code traced it step by step and
    found the app was fine: ferry's cache needs a real event-loop turn that
    widget-test fake time doesn't give. We fixed the test, not the app, and
    confirmed in real headless Chrome.
- **Rejected.** At kickoff I stopped an unscoped shell read and moved the session
  to plan mode until the plan was agreed. I also rewrote parts of the AI-drafted
  decision log in my own words.

**Verification:** strict analysis, the test suite (mutation-checked on the
headline test), contract tests against generated types, reading the generated
imports, and manual click-throughs (the flow, refresh on every page, the declined
path).
