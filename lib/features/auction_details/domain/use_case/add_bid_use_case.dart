import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';

import 'package:tradpool/features/auction_details/data/model/add_bid_response.dart';
import 'package:tradpool/features/auction_details/domain/repository/add_bid_repositroy.dart';

abstract class AddBidUseCase {
  Future<Either<Failure, AddBidResponse>> addBid(
      String auctionId, int price, String userId);
}

class AddBidUseCaseImp implements AddBidUseCase {
  final AddBidRepository addBidRepository;

  AddBidUseCaseImp(this.addBidRepository);

  @override
  Future<Either<Failure, AddBidResponse>> addBid(
      String auctionId, int price, String userId) async {
    return await addBidRepository.addBid(auctionId, price, userId);
  }
}
