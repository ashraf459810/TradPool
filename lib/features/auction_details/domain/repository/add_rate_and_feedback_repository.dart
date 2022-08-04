import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';

abstract class RateAndFeedBackRepository {
  Future<Either<Failure,AuctionDetailsModel>> rateAndFeedBack(String type , String auctionId,String rate,String feedBack,String userId);
}