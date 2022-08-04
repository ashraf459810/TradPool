import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/notifications/data/model/notification_model.dart';
import 'package:tradpool/features/notifications/data/remote_data_source/get_notificarions_remote_data.dart';
import 'package:tradpool/features/notifications/domain/repository/fetchnotification.dart';

class FetchUserNotificationImp implements FetchUserNotificationRepository {
  final NetworkInf networkInf;
  final FetchUserNotificationRemoteData fetchUserNotificationRemoteData;

  FetchUserNotificationImp(
      this.networkInf, this.fetchUserNotificationRemoteData);

  @override
  Future<Either<Failure, NotificationModel>> fetchUserNotifications(
      String clientId, int page, int size) async {
    if (await networkInf.isConnected) {
      try {
        final response = await fetchUserNotificationRemoteData
            .fetchUserNotification(clientId, page, size);

        return Right(notificationModelFromJson(response));
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> markNotificationSeen(
      String notificationId) async {
    if (await networkInf.isConnected) {
      try {
        final response = await fetchUserNotificationRemoteData
            .markNotificationSeen(notificationId);

        // ignore: void_checks
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}
