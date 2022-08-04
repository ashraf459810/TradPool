import 'package:dartz/dartz.dart';

import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/auction_details/data/data_source/get_step_remote_data.dart';
import 'package:tradpool/features/auction_details/domain/repository/get_step_repository.dart';

class GetStepRepositoryImp implements GetStepRepository {
  final GetStepRemoteData getStepRemoteData;
  final NetworkInf networkInf;

  GetStepRepositoryImp(this.getStepRemoteData, this.networkInf);
  @override
  Future<Either<Failure, dynamic>> getStep(dynamic auctionId) async {
    if (await networkInf.isConnected) {
      try {
        final step = await getStepRemoteData.getStep(auctionId);

        return Right(step);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}
