#!/usr/bin/env bash
# Analyze and test every package in the workspace. Pub workspaces have no
# root test command, so this walks the members. Stops on the first failure.
set -euo pipefail

cd "$(dirname "$0")/.."

dart_packages=(packages/graphql_api packages/local_backend)
flutter_packages=(packages/design_system packages/checkout_feature apps/checkout_app)

has_tests() {
  [ -d "$1/test" ] && [ -n "$(find "$1/test" -name '*_test.dart' -print -quit)" ]
}

flutter pub get

for package in "${dart_packages[@]}"; do
  echo "==> $package"
  (cd "$package" && dart analyze --fatal-infos)
  if has_tests "$package"; then
    (cd "$package" && dart test)
  else
    echo "    no tests yet"
  fi
done

for package in "${flutter_packages[@]}"; do
  echo "==> $package"
  (cd "$package" && flutter analyze --no-pub --fatal-infos)
  if has_tests "$package"; then
    (cd "$package" && flutter test --no-pub)
  else
    echo "    no tests yet"
  fi
done

echo "All packages analyzed and tested."
