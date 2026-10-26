# Decision Flow

A running record of the choices made building this checkout, and why. SOLUTION
covers the design as it stands; this is how it got there, including the calls I
went back on.

## Step 0 — Foundation

**Brand** Made up a name, Brightnook, so it doesn't look like anyone's real
product.

**Workspace** I started with five packages, which was more than this needed (Step
8). The in-app server in its own package was right from the start though.

**SDK floor** Every package says sdk ^3.10.0. The GraphQL generator holds the
workspace on an older analyzer, so the language version has to stay where that
analyzer can read it. I used AI to check the package versions on pub.dev before
writing anything, which I think saved me an evening of resolution errors.

## Step 1 — Contract and codegen

**Codegen first** It was the one real unknown, so it went first, and ferry
generated on the first run once the versions were pinned. graphql_codegen was the
fallback but sits behind the same analyzer limit.

**First contract test** It passed. Then I broke the server on purpose to watch
it fail and it just hung for 30 seconds - ferry turns a response that doesn't
fit the types into an error, and the test was waiting for data. It stops on the
first error now and names the field.

## Step 2 — The in-app server

**Replay first** The server looks the key up before it validates anything. I went
back and forth on whether a replay should be validated again and decided against
it - the original was valid when it was made.

**Slots in SAST** Generated in Johannesburg time and stored as UTC, so someone
reviewing from another time zone sees the times a customer here would.

## Step 3 — Domain and data

**Unknown or definite** A failed confirm goes one of two ways. A network error
means we don't know if the order was made, so the key stays. A slot that's gone
means nothing was made, so the attempt goes back to draft. It's an exhaustive
switch, so a new kind of failure has to pick a side.

**One use case** Only PlaceOrder got one, because that's where the logic is. The
reads go straight to the repositories.

## Step 4 — Routing and sign-in

**go_router** Order links have to load on their own and survive a refresh, so URL
routing was a requirement this time. Pinned to 17 because 18 moved onto the new
standalone Material package, a migration that had nothing to do with routing.

## Step 5 — Screens

**Plain first** Every screen started as plain Material with the styling to come
after. As it turned out most of the styling didn't happen (Step 7).

**Testing the flip** The journey test got stuck on pending. I used AI to trace
it one step at a time and the app was fine - ferry's cache needs a real turn of
the event loop and widget tests run on fake time. I fixed the test and checked
the repository tests in a real Chrome to be sure.

## Step 6 — Robustness

**Decoded from=** Flutter web writes the sign-in URL back to the address bar
decoded, so after a refresh a checkout link with a slot looked like two
parameters and the slot fell off. I only caught it in a screenshot while
testing. Reading everything after from= as the return location fixed it.

## Step 7 — Finishing

**Mobile** Ran on an Android emulator as a release build, because the emulator
didn't have room for the debug one. The iOS build compiles; I didn't click
through it.

## Step 8 — Simplifying

**Three packages** The feature and the theme moved into the app. The layer rules
are only a test now, which is weaker than a pubspec stopping the import, but five
packages for one feature was hard to justify.

**No get_it** One file of plain constructors. For an app this size I find it
easier to read than a container. If the object graph grows that might change.

**One error type** The data layer maps straight to AppFailure now. The second
hierarchy was carrying detail nobody read.

**Fewer tests** Down to about a third. I kept the ones that prove a requirement.
