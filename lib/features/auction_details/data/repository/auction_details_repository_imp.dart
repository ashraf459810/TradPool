import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/auction_details/data/data_source/get_auction_details_remote_data.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';
import 'package:tradpool/features/auction_details/domain/repository/get_auctions_repository.dart';

class AuctionDetailsImp implements GetAuctionDetailsRspository {
  final GetAuctionDetailsRemoteData auctionDetailsRemoteData;
  final NetworkInf networkInf;

  AuctionDetailsImp(this.auctionDetailsRemoteData, this.networkInf);

  @override
  Future<Either<Failure, AuctionDetailsModel>> getAuctionDetails(
      String auctionId,String userId) async {
    if (await networkInf.isConnected) {
      // try {
        final result =
            await auctionDetailsRemoteData.getAuctionDetails(auctionId, userId);

        return Right(result);
      // } catch (e) {

      //   return Left(ServerFailure(e.error));
      // }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}
