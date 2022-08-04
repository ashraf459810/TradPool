part of 'verfication_bloc.dart';

abstract class VerficationEvent extends Equatable {
  const VerficationEvent();

  @override
  List<Object> get props => [];
}

class ToVerfiyevent extends VerficationEvent {
  final String mobile;
  final String code;

  const ToVerfiyevent(this.mobile, this.code);
}
