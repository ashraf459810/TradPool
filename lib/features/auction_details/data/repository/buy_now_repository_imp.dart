import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/auction_details/data/data_source/buy_now_remote_data.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';
import 'package:tradpool/features/auction_details/domain/repository/buy_now_repository.dart';

class BuyNowRepositoryImp implements BuyNowRepository {
  final NetworkInf networkInf;
  final BuyNowRemoteData buyNowRemoteData;

  BuyNowRepositoryImp(this.networkInf, this.buyNowRemoteData);

  @override
  Future<Either<Failure, AuctionDetailsModel>> buyRepository(String userId, String auctionId) async {
      if (await networkInf.isConnected) {
      try {
      final response =
          await buyNowRemoteData.buyNow(userId, auctionId);

      return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
    
  }
}
