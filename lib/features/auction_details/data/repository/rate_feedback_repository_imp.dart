import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/auction_details/data/data_source/add_rate_feedback_remote_data.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';
import 'package:tradpool/features/auction_details/domain/repository/add_rate_and_feedback_repository.dart';

class RateAndFeedBackRepositoryImp implements RateAndFeedBackRepository{
  final NetworkInf networkInf;
  final RateAndFeedBackRemoteData rateAndFeedBackRemoteData;

  RateAndFeedBackRepositoryImp(this.networkInf, this.rateAndFeedBackRemoteData);

  @override
  Future<Either<Failure, AuctionDetailsModel>> rateAndFeedBack(String type, String auctionId, String rate, String feedBack, String userId) async {
     if (await networkInf.isConnected) {
      try {
        final step = await rateAndFeedBackRemoteData.rateAndFeedBack(type, auctionId, feedBack, rate, userId);

        return Right(step);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
  
}