part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class Loading extends RegisterState {}

class Error extends RegisterState {
  final String error;

  const Error(this.error);
}

class RegisterResponse extends RegisterState {
  final String result;

  const RegisterResponse(this.result);
}
