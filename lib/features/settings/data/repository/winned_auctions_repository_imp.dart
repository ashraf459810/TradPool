
import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/settings/data/model/winned_auctions_model.dart';
import 'package:tradpool/features/settings/data/remote_data/get_winned_auctions.dart';

import '../../domain/repository/winned_auctions_repository.dart';

class WinnedAuctionsRepositoryImp implements WinnedAuctionsRepository {
final NetworkInf networkInf;
final WinnedAuctionsRemoteData winnedAuctionsRemoteData;

  WinnedAuctionsRepositoryImp(this.networkInf, this.winnedAuctionsRemoteData);

  @override
  Future<Either<Failure, WinnedAuctionsModel>> winnedRepository(String userId, String page, String size) async {
      if (await networkInf.isConnected) {
      try {
        final response = await winnedAuctionsRemoteData.winnedAuctions(userId, page, size);



        return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }}
}