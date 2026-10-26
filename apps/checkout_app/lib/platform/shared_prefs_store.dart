import 'package:checkout_app/features/checkout/checkout.dart';
import 'package:local_backend/local_backend.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// One adapter for both storage ports: the in-app server's database
/// ([KeyValueStore]) and the client's session and checkout attempt
/// ([LocalStore]). SharedPreferencesAsync keeps no in-memory cache, so a tab
/// reads what another tab wrote. On web that's localStorage; on mobile, the
/// platform's own storage.
class SharedPrefsStore implements KeyValueStore, LocalStore {
  SharedPrefsStore([SharedPreferencesAsync? preferences])
    : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  @override
  Future<String?> read(String key) => _preferences.getString(key);

  @override
  Future<void> write(String key, String value) =>
      _preferences.setString(key, value);

  @override
  Future<void> remove(String key) => _preferences.remove(key);

  @override
  Future<Map<String, String>> readAll({required String prefix}) async {
    final Set<String> keys = (await _preferences.getKeys())
        .where((String key) => key.startsWith(prefix))
        .toSet();
    final Map<String, String> values = <String, String>{};
    for (final String key in keys) {
      final String? value = await _preferences.getString(key);
      if (value != null) {
        values[key] = value;
      }
    }
    return values;
  }
}
