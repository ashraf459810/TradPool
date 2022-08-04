import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/splash/data/data_source/save_token_remote_data.dart';
import 'package:tradpool/features/splash/domain/repositories/save_token_repository.dart';

class SaveTokenRepositoryImp implements SaveTokenRepository {
  final SaveFireBaseTokenRemoteDate saveFireBaseTokenRemoteDate;
  final NetworkInf networkInf;

  SaveTokenRepositoryImp(this.saveFireBaseTokenRemoteDate, this.networkInf);

  @override
  Future<Either<Failure, void>> savetoken(String token, String fcmToken) async {
    if (await networkInf.isConnected) {
      // try {
      var response =
          await saveFireBaseTokenRemoteDate.saveFcmToken(token, fcmToken);

      return Right(response);
      // } catch (e) {
      //   return Left(ServerFailure(e));
      // }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}
