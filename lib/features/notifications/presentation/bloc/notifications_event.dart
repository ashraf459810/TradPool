part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class FetchUserNotificationEvent extends NotificationsEvent {
  final int page;
  final int size;

  const FetchUserNotificationEvent(this.page, this.size);
}

class MarkNotificationSeenEvent extends NotificationsEvent {
  final String notificationId;

  const MarkNotificationSeenEvent(this.notificationId);
}

class NotificationRingEvent extends NotificationsEvent{

  final String notificationsCount;

  const NotificationRingEvent(this.notificationsCount);

}
