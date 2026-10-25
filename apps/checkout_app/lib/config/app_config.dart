/// Settings read from `--dart-define`, with defaults so the app runs with no
/// flags at all.
class AppConfig {
  const AppConfig({required this.networkDelay, required this.holdDelay});

  factory AppConfig.fromEnvironment() => const AppConfig(
    networkDelay: Duration(
      milliseconds: int.fromEnvironment('NETWORK_DELAY_MS', defaultValue: 400),
    ),
    holdDelay: Duration(
      milliseconds: int.fromEnvironment('HOLD_DELAY_MS', defaultValue: 2500),
    ),
  );

  /// Added before every query and mutation, so loading states and a double
  /// click can actually be seen.
  final Duration networkDelay;

  /// How long the simulated card provider takes to place a hold.
  final Duration holdDelay;
}
