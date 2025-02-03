abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String uid;

  AuthSuccess({required this.uid});
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}
