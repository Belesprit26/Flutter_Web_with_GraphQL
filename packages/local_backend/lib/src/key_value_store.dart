/// The server's database stand-in: string values under string keys. Every
/// record gets its own key, so two browser tabs never overwrite each other's
/// data. The app provides an adapter over the device's storage.
abstract interface class KeyValueStore {
  Future<String?> read(String key);

  Future<void> write(String key, String value);

  /// Every stored key that starts with [prefix], with its value.
  Future<Map<String, String>> readAll({required String prefix});
}

/// Keeps everything in a map. For tests, and anywhere persistence isn't wanted.
class InMemoryKeyValueStore implements KeyValueStore {
  InMemoryKeyValueStore([Map<String, String>? initial])
    : _values = <String, String>{...?initial};

  final Map<String, String> _values;

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String value) async {
    _values[key] = value;
  }

  @override
  Future<Map<String, String>> readAll({required String prefix}) async =>
      <String, String>{
        for (final MapEntry<String, String> entry in _values.entries)
          if (entry.key.startsWith(prefix)) entry.key: entry.value,
      };
}
