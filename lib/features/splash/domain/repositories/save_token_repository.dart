import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';

abstract class SaveTokenRepository {
  Future<Either<Failure, void>> savetoken(String token, String fcmToken);
}
