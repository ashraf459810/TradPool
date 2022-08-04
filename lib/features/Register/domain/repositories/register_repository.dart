import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/register/data/models/create_user.dart';

abstract class RegisterRepository {
  Future<Either<Failure, String>> createUser(CreateUserModel createUser);
}
