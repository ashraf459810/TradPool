import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/home/data/model/support_type_model.dart';
import 'package:tradpool/features/home/data/remote_data_source/get_support_type_remote_data.dart';
import 'package:tradpool/features/home/domain/repository/support_repositroy.dart';

class SupportTypeRepositoryImp implements SupportTypeRespository {
  final NetworkInf networkInf;
  final SupportTypeRemoteData supportTypeRemoteData;

  SupportTypeRepositoryImp(this.networkInf, this.supportTypeRemoteData);

  @override
  Future<Either<Failure, List<SupportTypeModel>>> supportRepository(String code) async {
    if (await networkInf.isConnected) {
      try {
      final response =
          await supportTypeRemoteData.getSupportType(code);

      return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}