import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/auction_details/data/model/add_bid_response.dart';

abstract class AddBidRepository {
  Future<Either<Failure, AddBidResponse>> addBid(
      String auctionId, int price, String userId);

}
