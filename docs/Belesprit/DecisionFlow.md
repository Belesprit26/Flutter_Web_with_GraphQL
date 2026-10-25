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

## Step 3 — Domain and data

**Result, and two kinds of error** Repositories hand back a Result - a value or
a failure, never a thrown exception. Underneath, the data layer throws
exceptions that say what went wrong, and one mapper turns them into failures
that say what to tell the user. A user never sees a stack trace and a log line
never says "something went wrong".

**The key belongs to the attempt, not the click** The idempotency key gets
minted once when a checkout attempt starts and it's saved before the request
goes out. A retry, a refresh or a second tap all reuse it. I've built
server-side idempotency before and the weak spot was the client making a fresh
key per tap - the server can't tell a retry from a new order then. I checked the
test would actually catch that by making the use case mint a key per click - the
reload and retry cases both failed with two orders.

**Single-flight** Two confirms for the same selection at the same moment share
one request. Without it both would find no saved attempt, both make a key, and
the server would quite correctly make two orders. Switching it off fails the
headline test, which is the point of having it.

**Unknown isn't no** A failed confirm is one of two things. A definite no - slot
taken, bad input - means nothing was made, so the attempt goes back to draft and
a changed selection gets a new key. A network failure means we don't know, so
the attempt stays submitting and the next try reuses the key - the server either
replays or creates, never both. That split is an exhaustive switch, so a new
kind of failure has to pick a side.

**Use cases revisited** There's one use case and it's PlaceOrder - it owns the
whole attempt: confirm, resume after a reload and abandon after a decline. The
reads go straight from the view model to the repository. A use case that only
forwards a call is a file and a hop that does nothing, and here the logic all
lives in one place.

**One mapper for every order** OrderDetails, CreateOrder and OrderUpdated all
select the same fragment, so the generated classes share an interface and one
mapper covers all 3. An enum value the app doesn't know fails loudly instead of
being guessed.

**Watching an order is the repository's job** The repository watches the order
query and keeps the subscription open until the order is final. ferry only
writes subscription results to its cache while something is listening, and that
cache write is what makes the query show the new status. The page doesn't know
any of that - it gets orders. It only gets told "not found" once the server has
said so, never while it's still loading.

## Step 4 — Routing and sign-in

**go_router this time** Order links have to load on their own, survive a
refresh and come back after sign-in, so URL routing is the requirement here and
not a nice-to-have. go_router with path URLs, no #. It's pinned to 17 - 18 moved
onto the new standalone Material package, which is a change across the whole app
for nothing the routing needs. Upgrading later is a version bump and a dart fix.

**The redirect is a pure function** resolveRedirect takes "signed in?" and the
location and says where to go instead. No widgets and no context, so every
branch has a unit test - including the ones that try to turn sign-in into an
open redirect with a from= pointing somewhere else. It's synchronous on purpose
as well: an async redirect would stop the history replace after a confirm from
working.

**The selection lives in the URL** /checkout?services=a,b&slot=x. A refresh or a
shared link puts you back where you were, and it's what lets checkout survive
the trip through sign-in. The card isn't in the URL - it defaults to the first
saved card.

**Ready before the first frame** The session is restored and the server has
loaded its orders before runApp. Otherwise a signed-in refresh of an order page
bounces through sign-in, and the first query can reach a server that hasn't
loaded anything yet.

**Screens don't know about the router** The feature package has no go_router in
it. Screens take callbacks and the router in the app decides where they go - the
router is the app's business, the same way the data layer doesn't know about the
UI.

**Simulated sign-in** One tap as the demo user, with a fixed id so order links
keep working between sessions. Another name gets its own id, which is how you
show that someone else's order link says not found. Signing out clears the
GraphQL cache so the next person doesn't see the last one's data.

## Step 5 — Screens

**Bare bones before polish** The first version of every screen is plain
Material - a list, a few chips, a button. It's what the brief asks for and
nothing else, and the styling goes in as its own commits after. If time runs
out, the thing that's finished is the thing that was asked for.

**One view model per page, made by the route** Each page gets a fresh view model
when it opens and loses it when it closes. It's keyed on what the page is
about - the order id, or the set of services - so picking a slot rewrites the
URL without throwing the page away.

**Confirm can't fire twice** The confirm button runs through a Command, and a
Command ignores a second run while the first is going. The button greys out
too, but that's for the user - the guard is what actually stops it. There's a
test that presses it twice without waiting and checks one request went out.

**Checkout looks at the attempt first** Before showing the form, checkout
checks the saved attempt. If the last confirm never got its answer it says
"Finishing your checkout..." and sends it again with the same key. If you've
come back to a checkout that already became an order, it says so and links to
it instead of showing a form you could submit again. Placing an order also
replaces the history entry, but I'm not relying on that alone.

**Pending, then placed** The order page shows the timeline with the hold step
spinning until the bank answers. If it's taking more than 10 seconds it says
it's safe to leave - it doesn't fail anything, because the server might still
finish. A declined card shows the reason and a "Try again" that starts a fresh
attempt.

**Testing the flip** I wrote a test that goes through the whole journey on the
real screens - pick 2 services, pick a slot, place the hold, watch it go from
pending to placed. It got stuck on pending. The server had placed the hold and
the subscription had delivered it - ferry's cache just needs a real turn of the
event loop before the query re-emits, and Flutter's widget tests run on fake
time. Letting a moment of real time pass fixed the test, and I ran the
repository tests in a real Chrome to be sure the app itself was fine.
