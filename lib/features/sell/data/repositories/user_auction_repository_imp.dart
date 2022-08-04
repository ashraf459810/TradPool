import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/sell/data/datasources/get_auctions_remote_data.dart';
import 'package:tradpool/features/sell/data/models/all_auctions_model.dart';
import 'package:tradpool/features/sell/domain/repositories/user_auctions_repositroy.dart';

class UserAuctionsRepositoryImp implements UserAuctionsRepository {
  final UserAuctionsRemoteData userAuctionsRemoteData;
  final NetworkInf networkInf;

  UserAuctionsRepositoryImp(this.userAuctionsRemoteData, this.networkInf);

  @override
  Future<Either<Failure, UserAuctionsModel>> getAuctions(
      int page, int size, String userToken) async {
    if (await networkInf.isConnected) {
      // try {
        final response =
            await userAuctionsRemoteData.getAuctions(page, size, userToken);

        return Right(response);
      // } catch (e) {
      //   return const Left(ServerFailure());
      // }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}
