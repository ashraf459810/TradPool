import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';

abstract class GetAuctionDetailsRspository {
  Future<Either<Failure, AuctionDetailsModel>> getAuctionDetails(
      String auctionId,String userId);
}
