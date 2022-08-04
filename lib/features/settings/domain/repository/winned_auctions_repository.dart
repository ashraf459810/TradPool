import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/settings/data/model/winned_auctions_model.dart';

abstract class WinnedAuctionsRepository {
  Future<Either<Failure,WinnedAuctionsModel>> winnedRepository (String userId , String page, String size);
}