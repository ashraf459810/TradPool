import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/settings/data/model/user_history_model.dart';
import 'package:tradpool/features/settings/data/remote_data/user_history_remote_data.dart';
import 'package:tradpool/features/settings/domain/repository/user_history_repository.dart';

class UserHistoryRepositoryImp implements UserHistoryRepository {
  final NetworkInf networkInf;
  final UserHistoryRemoteData userHistoryRemoteData;

  UserHistoryRepositoryImp(this.networkInf, this.userHistoryRemoteData);

  @override
  Future<Either<Failure, UserHistoryModel>> userHistory(String auctionId, String page, String size) async {

             if (await networkInf.isConnected) {
      try {
        final response = await userHistoryRemoteData.userHistory(auctionId, page, size);


        // ignore: void_checks
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  
  }
}