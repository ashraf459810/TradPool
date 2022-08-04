import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/features/notifications/data/model/notification_model.dart';
import 'package:tradpool/features/notifications/domain/use_case/fetch_notificatinos.dart';
import 'package:tradpool/features/notifications/domain/use_case/mark_notification_seen_use_case.dart';

import '../../../../injection_container.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final FetchUserNotificationsUseCase fetchUserNotificationsUseCase;
  final MarkNotificationSeenUseCase markNotificationSeenUseCase;
  NotificationsBloc(
      this.fetchUserNotificationsUseCase, this.markNotificationSeenUseCase)
      : super(NotificationsInitial()) {
    List<NotificationsList> notification = [];
    on<NotificationsEvent>((event, emit) async {
      if (event is NotificationRingEvent){
        emit(Loading());
          log("here from notification bloc");
          if (int.parse(event.notificationsCount) > int.parse(sl<SharedPreferences>().getString("notificationCounter"))){
        emit(NotificationRingState());
        }
      }
      if (event is FetchUserNotificationEvent) {
        // emit(Loading());
        var token = await SharedPreferences.getInstance()
            .then((value) => value.getString(Con.token));
        final result = await fetchUserNotificationsUseCase
            .fetchUserNotificationUseCase(token, event.page, event.size);
        result.fold((l) => emit(Error(l.error)), (r) {
          if (notification.isEmpty) {
            notification = r.notifications;
          } else {
            notification.addAll(r.notifications);
          }
          emit(FetchUserNotificationState(notification));
        });
      }
      if (event is MarkNotificationSeenEvent) {
        markNotificationSeenUseCase
            .markNotificationSeenUseCase(event.notificationId);
        emit(MarkUserNotificationSeenState());
      }
    });
  }
}
