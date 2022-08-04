part of 'log_in_bloc.dart';

abstract class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class ToLoginEvent extends LogInEvent {
  final String mobileNumber;

  const ToLoginEvent(this.mobileNumber);
}
