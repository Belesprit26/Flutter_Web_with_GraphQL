# Brightnook checkout

A web-first Flutter checkout. Pick one or two services, a time and a saved card,
and the app places a temporary hold; the order page shows it pending, then
placed. Typed GraphQL with code generation against a schema in this repo,
answered by an in-app server, so there's no backend to run. The same code runs
on iOS and Android.

Design and trade-offs: [SOLUTION.md](SOLUTION.md). Decisions:
[docs/Belesprit/DecisionFlow.md](docs/Belesprit/DecisionFlow.md).

## Run

Tested on Flutter 3.47.8; the lockfile needs Flutter 3.47+.

```sh
cd apps/checkout_app
flutter pub get
flutter run -d chrome     # or `flutter run` for a simulator or emulator
```

Optional: `--dart-define=NETWORK_DELAY_MS=400` and `--dart-define=HOLD_DELAY_MS=2500`.

## Demo

Sign in with "Continue as demo user". Visa •••• 4242 and Mastercard •••• 5454
place holds; the "always declines" card •••• 0002 shows the failed path. Orders
and the session live in this browser's storage (or on the device), so an order
link opened in another browser shows not found.

## Test

```sh
tool/test_all.sh          # analyze + 38 tests
tool/check_codegen.sh     # fails if the generated GraphQL code is stale
```

After changing the schema: `cd packages/graphql_api && dart run build_runner build`.

## Release web build

```sh
cd apps/checkout_app && flutter build web --release
npx serve -s build/web
```

The host must answer unknown paths with `index.html`, or refreshing a deep link
returns a 404.
