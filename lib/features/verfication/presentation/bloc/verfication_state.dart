part of 'verfication_bloc.dart';

abstract class VerficationState extends Equatable {
  const VerficationState();

  @override
  List<Object> get props => [];
}

class VerficationInitial extends VerficationState {}

class Loading extends VerficationState {}

class Error extends VerficationState {
  final String error;

  const Error(this.error);
}

class VerfiyResponse extends VerficationState {
  final VerificationResponse verificationResponse;

  const VerfiyResponse(this.verificationResponse);
}
