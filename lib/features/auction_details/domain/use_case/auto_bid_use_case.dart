import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/auction_details/domain/repository/auto_bid_repository.dart';

abstract class AutoBidUseCase {
  Future<Either<Failure, void>> autoBidUseCase(
      String auctionId, String price, String userId);
}

class AutoBidUseCaseImp implements AutoBidUseCase {
  final AutoBidRepositorry autoBidRepositorry;

  AutoBidUseCaseImp(this.autoBidRepositorry);

  @override
  Future<Either<Failure, void>> autoBidUseCase(
      String auctionId, String price, String userId) async {
    return await autoBidRepositorry.autoBidRepo(auctionId, price, userId);
  }
}
