import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/notifications/data/model/notification_model.dart';
import 'package:tradpool/features/notifications/domain/repository/fetchnotification.dart';

abstract class FetchUserNotificationsUseCase {
  Future<Either<Failure, NotificationModel>> fetchUserNotificationUseCase(
      String clientId, int page, int size);
}

class FetchUserNotificationsImp implements FetchUserNotificationsUseCase {
  final FetchUserNotificationRepository fetchUserNotificationRepository;

  FetchUserNotificationsImp(this.fetchUserNotificationRepository);

  @override
  Future<Either<Failure, NotificationModel>> fetchUserNotificationUseCase(
      String clientId, int page, int size) async {
    return await fetchUserNotificationRepository.fetchUserNotifications(
        clientId, page, size);
  }
}
