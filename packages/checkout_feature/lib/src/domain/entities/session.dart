import 'package:equatable/equatable.dart';

/// Who is signed in. Simulated: no passwords, no tokens.
class Session extends Equatable {
  const Session({required this.userId, required this.displayName});

  final String userId;
  final String displayName;

  @override
  List<Object?> get props => <Object?>[userId, displayName];
}
