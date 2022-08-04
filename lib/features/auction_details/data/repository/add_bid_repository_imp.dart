import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/auction_details/data/data_source/add_bid_remote_data.dart';
import 'package:tradpool/features/auction_details/data/model/add_bid_response.dart';
import 'package:tradpool/features/auction_details/domain/repository/add_bid_repositroy.dart';

class AddBidRespositoryImp implements AddBidRepository {
  final AddBidRemoteDate addBidRemoteDate;
  final NetworkInf networkInf;

  AddBidRespositoryImp(this.addBidRemoteDate, this.networkInf);

  @override
  Future<Either<Failure, AddBidResponse>> addBid(
      String auctionId, int price, String userId) async {
    if (await networkInf.isConnected) {
      try {
        final bidders = await addBidRemoteDate.addBid(auctionId, price, userId);

        return Right(bidders);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}
