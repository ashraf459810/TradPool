import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/home/data/model/all_auctions_model.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:tradpool/features/home/data/remote_data_source/remote_data_source.dart';
import 'package:tradpool/features/home/domain/repository/all_auctions_repository.dart';

class AllAuctionsRespositoryImp implements AllAuctionsRepository {
  final AllAuctionsRemoteData allAuctionsRemoteData;
  final NetworkInf networkInf;

  AllAuctionsRespositoryImp(
    this.allAuctionsRemoteData,
    this.networkInf,
  );

  @override
  Future<Either<Failure, AllAuctionsModel>> getAllAuctions(
      int page, int size) async {
    if (await networkInf.isConnected) {
      try {
      final createUserResponse =
          await allAuctionsRemoteData.getAllAuctions(page, size);

      return Right(createUserResponse);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}
