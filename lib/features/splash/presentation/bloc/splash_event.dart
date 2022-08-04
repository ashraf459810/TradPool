part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class SaveFcmTokenEvent extends SplashEvent {}

class NavigateEvent extends SplashEvent {
  final String id;

  const NavigateEvent(this.id);
}
