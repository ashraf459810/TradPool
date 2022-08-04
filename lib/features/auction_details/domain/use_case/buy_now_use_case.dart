import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';
import 'package:tradpool/features/auction_details/domain/repository/buy_now_repository.dart';

abstract class BuyNowUseCase {
  Future <Either<Failure,AuctionDetailsModel>> buyNowUseCase ( String userId , String auctionId);
}


class BuyNowUseCaseImp implements BuyNowUseCase {
  final BuyNowRepository buyNowRepository ;

  BuyNowUseCaseImp(this.buyNowRepository);

  @override
  Future<Either<Failure, AuctionDetailsModel>> buyNowUseCase(String userId, String auctionId) async {
  return await buyNowRepository.buyRepository(userId, auctionId);
  }
}