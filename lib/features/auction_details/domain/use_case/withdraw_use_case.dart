import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';
import 'package:tradpool/features/auction_details/domain/repository/withdraw_repository.dart';

abstract class WithdrawUseCase {
  Future<Either<Failure,AuctionDetailsModel>> withdrawUseCase ( String clientId, String auctionid);
}



class WithdrawUseCaseImp implements WithdrawUseCase {
  final WithDrawRepository withDrawRepository;


  WithdrawUseCaseImp(this.withDrawRepository, );

  @override
  Future<Either<Failure, AuctionDetailsModel>> withdrawUseCase(String clientId, String auctionid) async {
    return await withDrawRepository.withdrawRepository(clientId,auctionid);
  }
}