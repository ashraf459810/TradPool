part of 'log_in_bloc.dart';

abstract class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object> get props => [];
}

class LogInInitial extends LogInState {}

class Loading extends LogInState {}

class Error extends LogInState {
  final String error;

  const Error(this.error);
}

class LoginResponse extends LogInState {
  final String response;

  const LoginResponse(this.response);
}
