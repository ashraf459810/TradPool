import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';

abstract class GetStepRepository {
  Future<Either<Failure, dynamic>> getStep(String auctionId);
}
