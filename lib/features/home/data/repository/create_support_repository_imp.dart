import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/home/data/remote_data_source/create_support_request.dart';
import 'package:tradpool/features/home/domain/repository/create_support_request_repository.dart';

class CreateSupportRepositoryImp implements CreateSupportRepository {
  final CreateSupportRequestRemoteData createSupportRequestRemoteData;
  final NetworkInf networkInf;

  CreateSupportRepositoryImp(this.createSupportRequestRemoteData, this.networkInf);

  @override
  Future<Either<Failure, void>> createSupportRepository(String userId, String supportId, String text) async {
    if (await networkInf.isConnected){

      try {
      var response = await createSupportRequestRemoteData.createSupportRequest(userId, supportId, text);
      // ignore: void_checks
      return Right(response);

      }catch (e ){
        return Left(ServerFailure(e.error));
      }

    }
    else {
      return const Left( NetWorkFailure());
    }
  }
}