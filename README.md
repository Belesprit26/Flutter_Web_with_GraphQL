# Brightnook checkout

A web-first Flutter checkout slice. Pick one or two home services, pick a time,
confirm with a saved card, and the app places a temporary hold and opens the
order, whose timeline goes from **pending** to **placed** when the hold is
confirmed. Typed GraphQL with code generation against a schema in this repo,
answered by an in-app server, so there's no backend to run. The same code runs on
iOS and Android.

Design, trade-offs and how duplicate orders are prevented: [SOLUTION.md](SOLUTION.md).
How the decisions were made, step by step: [docs/Belesprit/DecisionFlow.md](docs/Belesprit/DecisionFlow.md).

## Requirements

Tested on **Flutter 3.47.8 / Dart 3.13.7**. The committed lockfile needs Flutter
3.47+ (Dart 3.13+). Package constraints allow Dart 3.10+, so an older SDK may
re-resolve, but that is untested.

## Run

```sh
cd apps/checkout_app
flutter pub get          # resolves the whole pub workspace
flutter run -d chrome    # web
flutter run              # pick an iOS simulator or Android emulator
```

Optional: `--dart-define=NETWORK_DELAY_MS=400` (simulated network delay, default
400) and `--dart-define=HOLD_DELAY_MS=2500` (how long the card provider takes to
place a hold, default 2500).

## Try it

- **Sign in** - "Continue as demo user", or any name. Orders belong to whoever
  placed them, so another name sees the first user's order link as not found.
- **Cards** - Personal Visa •••• 4242 and Business Mastercard •••• 5454 place
  holds. "Test card - always declines" •••• 0002 shows the failed path.
- **Duplicates** - double-click "Place hold", or refresh straight after
  confirming: still one order.
- **Data lives in this browser** (localStorage) or on this device. An order link
  opened in incognito or another browser says "not found for this account in this
  browser". That's by design: there's no shared backend.

## Test

```sh
tool/test_all.sh         # analyze + test every package (116 tests)
tool/check_codegen.sh    # regenerate the GraphQL types; fails if the committed ones differ
```

Pub workspaces have no root test command, so `test_all.sh` walks the packages.

## Regenerate GraphQL types

The generated code is committed, so you only need this after editing the schema
or an operation:

```sh
cd packages/graphql_api && dart run build_runner build
```

## Release web build

```sh
cd apps/checkout_app && flutter build web --release
cd ../.. && dart run tool/serve_web.dart 8080   # serves with single-page fallback
```

Any static host works if it answers unknown paths with `index.html`. Without that,
refreshing a deep link such as `/orders/<id>` returns a 404 before Flutter loads.

## Layout

```
apps/checkout_app/        thin Flutter app: startup, dependency wiring, router, config
packages/checkout_feature domain / data / presentation for the checkout journey
packages/graphql_api      schema.graphql, operations, generated types, client factory
packages/local_backend    the in-app GraphQL server: resolvers, order state machine, simulated card provider
packages/design_system    brand, colour and spacing tokens, theme
tool/                     test_all.sh, check_codegen.sh, serve_web.dart
docs/Belesprit/           DecisionFlow.md
```
