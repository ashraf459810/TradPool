import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/verfication/data/models/verfication_model.dart';

abstract class VerficationRepository {
  Future<Either<Failure, VerificationResponse>> checkcode(
      String mobile, String code);
  Future<bool> getIsVerify();
  Future<String> getToken();
  Future<void> setIsVerify(bool value);
  Future<void> setToken(String token);
}
