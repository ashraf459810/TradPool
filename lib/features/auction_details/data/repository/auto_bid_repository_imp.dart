import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/auction_details/data/data_source/enable_auto_bid_remote.dart';
import 'package:tradpool/features/auction_details/domain/repository/auto_bid_repository.dart';

class AutoBidRepositoryImp implements AutoBidRepositorry {
  final NetworkInf networkInf;
  final AutoBidRemoteData autoBidRemoteData;

  AutoBidRepositoryImp(this.networkInf, this.autoBidRemoteData);

  @override
  Future<Either<Failure, void>> autoBidRepo(
      String auctionId, String price, String userID) async {
    if (await networkInf.isConnected) {
      try {
      final bidders =
          await autoBidRemoteData.autoBidRemoteData(userID, price, auctionId);

      return Right(bidders);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}
