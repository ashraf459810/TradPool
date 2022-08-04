import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/login/data/datasources/login_remote_data.dart';
import 'package:tradpool/features/login/domain/repositories/login_repository.dart';

typedef LoginResponse = Future<String> Function();

class LoginRepositoryImp implements LoginRepository {
  final LoginRemoteDate remoteData;
  final NetworkInf networkInfo;

  LoginRepositoryImp(this.remoteData, this.networkInfo);
  @override
  Future<Either<Failure, String>> login(String mobile) async {
    return await logintheuser(() {
      return remoteData.login(mobile);
    });
  }

  Future<Either<Failure, String>> logintheuser(
    LoginResponse loginResponse,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final createUserResponse = await loginResponse();

        return Right(createUserResponse);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}
