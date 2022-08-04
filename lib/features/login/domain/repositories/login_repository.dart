import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> login(String mobile);
}
