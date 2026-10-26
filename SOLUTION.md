# Solution

## 1. Overview

A customer picks one or two services, a slot and a saved card. The app places a
temporary hold and opens the order, which flips from pending to placed or
declined when the simulated card provider answers. One codebase runs on web, iOS
and Android.

## 2. Architecture

Three packages in a pub workspace: `graphql_api` (schema, operations, generated
types), `local_backend` (the in-app server) and `checkout_app`, with the feature
in `lib/features/checkout` split into domain, data and presentation. A test
fails the build if a layer imports what it shouldn't. View models are
`ChangeNotifier`s with `Command`s, created by their route. Dependencies are plain
constructors in `lib/dependencies.dart`. Repositories return a sealed `Result`
with a sealed `AppFailure`.

## 3. Typed GraphQL without a backend

The schema in `packages/graphql_api/lib/schema/schema.graphql` is the source of
truth. ferry generates the types; `tool/check_codegen.sh` catches stale generated
code. `LocalServerLink` answers in-process. Resolvers return maps, the only place
maps exist, and a contract test checks every operation against its generated
type. The order page keeps an `orderUpdated` subscription open until the order
is final; it sends the current state first, and its results land in ferry's
cache, which re-emits the order query. A real endpoint is a different `Link` in
`lib/dependencies.dart`.

## 4. Navigation, deep links and sign-in

go_router 17 with path URLs. Checkout and orders need sign-in; a signed-out
visit goes to `/sign-in?from=<location>` and comes back. The redirect is a pure
function that only accepts internal pages. The selection lives in the URL, and
the session and server load before `runApp`, so refresh works everywhere.

## 5. Avoiding duplicate financial outcomes

A `Command` ignores a second confirm while one is running. `PlaceOrderUseCase`
mints the idempotency key once per checkout attempt, saves it before the request
and reuses it on retries and after a reload; concurrent confirms share one
request. An unknown outcome keeps the key, a definite no returns the attempt to
draft. The server checks the key first and returns the original order; the
lookup and insert run in one synchronous block, like a unique index on
`(user_id, idempotency_key)`. Checkout reads the attempt on load, and success
replaces the history entry.

| Scenario | Result |
|---|---|
| Double-click confirm | Second click dropped |
| Refresh before the answer | Same key, same order |
| Network error, click again | Same key, one order |
| Slot rejected, pick another | New key |
| Declined, "Try again" | New attempt |
| Back after success | "Already placed" |
| Refresh while pending | Hold resumes on start |

The in-app server runs per tab, so two tabs submitting at once aren't protected,
and data is per browser. A lost answer followed by a changed selection can leave
two orders.

## 6. Optional item: one meaningful test

`duplicate_submission_test.dart` runs the real use case, store, client, link and
server through simultaneous confirms, a reload mid-confirm, a retry, a rejected
slot and a decline. It's the requirement with money attached, and it fails if
single-flight is off or the key is minted per click. 38 tests in total.

## 7. Trade-offs and what I'd do next

The first version of the in-app server did more than a lightweight data layer
needs (slot inventory, ownership). I cut it back; the fuller version is at tag
v1.0-submission. ferry pins an older analyzer, and go_router stays on 17. Not
built: a two-column layout, CI, a deploy, an iOS click-through. For production:
AppSync with real auth, a Postgres unique index, real pre-authorisation and
capture, and hold expiry.

## 8. AI usage

I planned the build with Claude and wrote
most of the code by hand and with Claude Code. I set the scope and architecture, made the call at each checkpoint, and reviewed and tested every step with AI. 
Accepted: its pub.dev check of package versions with AI before any code was written, which led to pinning go_router 17 and working within ferry's analyzer cap. 
Changed: a contract test that hung instead of failing when the server broke, rewritten to fail on the first error. 
Rejected: the planned robustness, polish and CI phases, which I cut as overbuilding, and later most of the in-app server's extra features. Verified with strict analysis, the tests, contract tests against the generated types, and manual click-throughs on web and Android.
