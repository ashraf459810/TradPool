part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class FetchUserNotificationState extends NotificationsState {
  final List<NotificationsList> notifications;

  const FetchUserNotificationState(this.notifications);
}

class Loading extends NotificationsState {}

class Error extends NotificationsState {
  final String error;

  const Error(this.error);
}

class MarkUserNotificationSeenState extends NotificationsState {}


class NotificationRingState extends  NotificationsState{}