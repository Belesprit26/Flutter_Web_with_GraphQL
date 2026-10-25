import 'package:equatable/equatable.dart';

/// Who is signed in. Simulated: no passwords, no tokens.
class Session extends Equatable {
  const Session({required this.userId, required this.displayName});

  /// The demo account: one consistent id, so order links keep working
  /// between sessions.
  static const Session demo = Session(
    userId: 'demo-user',
    displayName: 'Demo user',
  );

  /// A session for any name. The user id is the name as a slug, so the same
  /// name always gets the same orders. Null when the name has no letters or
  /// digits to make an id from.
  static Session? forName(String name) {
    final String displayName = name.trim();
    final String userId = displayName
        .toLowerCase()
        .replaceAll(RegExp('[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    if (userId.isEmpty) {
      return null;
    }
    return Session(userId: userId, displayName: displayName);
  }

  final String userId;
  final String displayName;

  @override
  List<Object?> get props => <Object?>[userId, displayName];
}
