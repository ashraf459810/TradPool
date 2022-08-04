import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';

abstract class CreateSupportRepository {
  Future<Either<Failure,void>> createSupportRepository(String userId, String supportId,String text);
}
