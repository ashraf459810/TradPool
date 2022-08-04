import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/buy/data/models/buy_model.dart';
import 'package:tradpool/features/buy/domain/repositories/paid_auctions_repository.dart';

abstract class PaidAuctionUseCase {

  Future<Either<Failure,List<BuyAuctionModel>>> getPaidAuction(String clientId);
}


class PaidAuctionUseCaseImp implements PaidAuctionUseCase{
  final PaidAuctionsRepository paidAuctionsRepository;

  PaidAuctionUseCaseImp(this.paidAuctionsRepository);

  @override
  Future<Either<Failure, List<BuyAuctionModel>>> getPaidAuction(String clientId) async {
    return await paidAuctionsRepository.getPaidAuctions(clientId);
  }
}