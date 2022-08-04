import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';
import 'package:tradpool/features/auction_details/data/data_source/user_withdraw.dart';
import 'package:tradpool/features/auction_details/domain/repository/withdraw_repository.dart';

class WithdrawRepositoryImp implements WithDrawRepository {
  final UserWithdrawRemoteData withdrawRemoteData ;
  final NetworkInf networkInf ;

  WithdrawRepositoryImp(this.withdrawRemoteData, this.networkInf);

  @override
  Future<Either<Failure, AuctionDetailsModel>> withdrawRepository(String userId, String auctionId) async {
    if (await networkInf.isConnected){

             try {
      final response =
          await withdrawRemoteData.userWithdraw(userId  , auctionId);

      return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
     }
  
  
}