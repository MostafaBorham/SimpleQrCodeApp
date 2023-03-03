part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

///Login States
class UserLoginingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class UserSuccessLoginState extends AuthState {
  final User? user;
  const UserSuccessLoginState({this.user});
  @override
  List<Object?> get props => [user];
}

class UserFailedLoginState extends AuthState {
  final String? message;
  const UserFailedLoginState({this.message});
  @override
  List<Object?> get props => [message];
}
