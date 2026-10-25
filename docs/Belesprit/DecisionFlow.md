# Decision Flow

A running record of the choices made building this checkout, and why. Shortest
useful explanation for each - enough that you don't have to reverse engineer the
reasoning from the code. README covers how to run it and SOLUTION covers the
design as it stands. This is how it got there, step by step, including the calls
I went back on.

## Step 0 — Foundation

**Brightnook** I made up a brand for it. It's a home services checkout and I
didn't want it looking like anyone's real product, yours included.

**One workspace, 5 packages** Pub workspace, one lockfile, no melos. The app is
thin - wiring, router and config - and the 4 packages hold everything else. The
one worth explaining is local_backend. It's the stand-in for a real backend, and
keeping it out of graphql_api means the client never knows the server is local.
Pointing at a real endpoint later is a different Link in the app and nothing
else moves.

**Pure Dart where it can be** graphql_api and local_backend have no Flutter in
them, so their tests run on the plain Dart VM in seconds. Same reasoning I've
used before, it's package boundaries now instead of folders - the pubspec stops
a bad import before a test has to.

**The SDK floor** Every package says sdk ^3.10.0. The GraphQL code generator
holds the whole workspace on an older analyzer, so the language version has to
stay where that analyzer can read it. I used AI to check the package versions
against pub.dev before starting, which was worth doing before rather than after.
The lockfile tells a different story - resolved on 3.47.8 it asks for Dart 3.13
because the newest test tooling does. So the README says what it was actually
tested on instead of the oldest SDK the constraints technically allow.

**Strict analysis** strict-casts, strict-inference and strict-raw-types are on,
plus avoid_dynamic_calls. The brief says no dynamic maps in app code and this is
what turns that into an analyzer error instead of a promise.

**One script for the checks** Pub workspaces don't have a root test command, so
tool/test_all.sh walks the packages - analyze, then test, stop on the first
failure. That's what runs before every commit.

## Step 1 — Contract and codegen

**Codegen first** The generator was the one real unknown, so it went first.
ferry's generator holds the whole workspace on an older analyzer - build_runner
2.15 and test 1.31 instead of the latest - and I used AI to check those
constraints on pub.dev before adding it, so it generated on the first run. The
fallback was graphql_codegen, but it sits behind the same limit, so it would
only have helped with a problem specific to ferry.

**The schema lives in the repo** schema.graphql in graphql_api is the source of
truth. The client types are generated from it and the in-app server has to
answer in its shape. Money is Int cents everywhere, never Float. Timestamps are
ISO strings that become DateTime in the data layer - a custom scalar would be a
serializer and a codegen config for one type.

**One status vocabulary** HOLD_PENDING, HOLD_PLACED and HOLD_FAILED are defined
once in the schema, and the server's state machine and the domain enum will use
those words as they are. Nothing to translate between layers means nothing to
drift.

**Snapshots don't get an id** BookedSlot and CardSnapshot are their own types
with no id on purpose. ferry's cache merges anything with the same id, so if an
order's slot pointed at the live Slot, the order would change when that slot's
availability did. Without an id they stay embedded under their order, which is
what a receipt should do. The flip side is OrderEvent - it has an id, so those
ids have to be unique across every order.

**Generated code is committed** A fresh clone runs without build_runner.
tool/check_codegen.sh regenerates and fails if anything differs, so the files
can't quietly go stale. With a schema, 6 operations and nested types the
generated code earns its keep - a server and client that disagree is a compile
error.

**The first contract test had to fail properly** Services goes through the real
ferry client and the real in-app link and has to come back as GServicesData. I
checked it actually catches drift by dropping priceCents from the server. The
first version just hung for 30 seconds - ferry turns a response that doesn't fit
the types into an error rather than data, and the test was waiting for data. Now
it stops on the first error and names the field.

## Step 2 — The in-app server

**A server, not a mock** local_backend is written the way resolvers on a real
backend would be - validate the input at the edge, check who's asking, do the
work in one place. The resolvers return maps and that's the only place in the
project maps exist. The client never sees them, it sees generated types, and
there's a contract test per operation proving the two fit.

**Replay first** createOrder looks the idempotency key up before it validates
anything. Same key and the same request gets the original order back, flagged as
a replay - it isn't validated again, the original was valid when it was made.
Same key with a different request gets rejected. A key means one request, not
one user.

**No await between the lookup and the insert** The replay check, the validation
and the insert run as one synchronous block. Dart finishes a synchronous block
before anything else gets a turn, so two requests with the same key can't both
miss the lookup. On a real backend that's a unique index on user and key with
INSERT ... ON CONFLICT. There's a test that fires two at the same moment and gets
one order.

**The key lives on the order** I changed this from the plan. It had the key and
the order as two separate records, which leaves a moment where the order is
saved and its key isn't - refresh in that moment and the replay misses and you
get a second order and a second hold. Now the key is a field on the order and
it's one write. Same shape as a key column with a unique index.

**Accepted isn't placed** The simulated gateway takes the hold request straight
away and answers 2.5 seconds later, like a webhook would. The order sits in
HOLD_PENDING in between and that's what the page shows. Settling is guarded - if
the order isn't pending any more it's a no-op, so a late or repeated answer
can't flip a finished order.

**Refresh while pending** A refresh kills the in-memory timer, so on start the
server goes through every pending order and asks again using the original
request time. If it's overdue it settles straight away. Without this the order
page would sit on pending forever.

**The subscription speaks first** orderUpdated sends the order as it is right
now before any changes. Otherwise a hold that settles between the page loading
the order and the subscription attaching gets lost. The server also starts
listening for changes before it reads the order, for the same reason.

**Slots in Johannesburg time** Four 2 hour windows a day, stored in UTC but
generated in SAST, so someone reviewing this from another time zone sees the
same times a customer here would. Slot ids are built from the date and hour so a
slot in a URL means the same window on every load. One booking per slot, and a
declined hold gives the slot back.
