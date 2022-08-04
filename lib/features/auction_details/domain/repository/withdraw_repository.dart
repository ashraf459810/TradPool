import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';

abstract class WithDrawRepository {
  Future <Either<Failure,AuctionDetailsModel>> withdrawRepository (String userId , String auctionId);
}



