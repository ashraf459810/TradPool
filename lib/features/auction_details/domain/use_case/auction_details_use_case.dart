import 'package:dartz/dartz.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';
import 'package:tradpool/features/auction_details/domain/repository/get_auctions_repository.dart';

abstract class AuctionDetailsUseCase {
  Future<Either<Failure, AuctionDetailsModel>> getAuctionDetailsUseCase(
      String auctionId,String userId);
}

class AuctionDetailsUseCaseImp implements AuctionDetailsUseCase {
  final GetAuctionDetailsRspository auctionDetailsRspository;

  AuctionDetailsUseCaseImp(this.auctionDetailsRspository);

  @override
  Future<Either<Failure, AuctionDetailsModel>> getAuctionDetailsUseCase(
      String auctionId,String userId) async {
    return await auctionDetailsRspository.getAuctionDetails(auctionId, userId);
  }
}
