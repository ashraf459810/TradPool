import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/notifications/data/model/notification_model.dart';

abstract class FetchUserNotificationRepository {
  Future<Either<Failure, NotificationModel>> fetchUserNotifications(
      String clientId, int page, int size);

  Future<Either<Failure, void>> markNotificationSeen(String notificationId);
}
