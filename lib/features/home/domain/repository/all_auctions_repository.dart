import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/home/data/model/all_auctions_model.dart';

abstract class AllAuctionsRepository {
  Future<Either<Failure, AllAuctionsModel>> getAllAuctions(int page, int size);
}
