import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/notifications/domain/repository/fetchnotification.dart';

abstract class MarkNotificationSeenUseCase {
  Future<Either<Failure, void>> markNotificationSeenUseCase(
      String notificationId);
}

class MarkNotificationSeenUseCaseImp implements MarkNotificationSeenUseCase {
  final FetchUserNotificationRepository fetchUserNotificationRepository;

  MarkNotificationSeenUseCaseImp(this.fetchUserNotificationRepository);

  @override
  Future<Either<Failure, void>> markNotificationSeenUseCase(
      String notificationId) async {
    return await fetchUserNotificationRepository
        .markNotificationSeen(notificationId);
  }
}
