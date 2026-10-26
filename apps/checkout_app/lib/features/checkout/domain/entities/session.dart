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

  final String userId;
  final String displayName;

  @override
  List<Object?> get props => <Object?>[userId, displayName];
}
