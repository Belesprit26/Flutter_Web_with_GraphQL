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
