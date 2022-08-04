part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class ToRegisterEvent extends RegisterEvent {
  final CreateUserModel createUserModel;

  const ToRegisterEvent(this.createUserModel);
}
