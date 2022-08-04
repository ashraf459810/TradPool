import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/sell/data/models/all_auctions_model.dart';

abstract class UserAuctionsRepository {
  Future<Either<Failure, UserAuctionsModel>> getAuctions(
      int page, int size, String userToken);
}
