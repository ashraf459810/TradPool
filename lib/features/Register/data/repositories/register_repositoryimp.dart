import 'dart:developer';

import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';

import 'package:tradpool/features/register/data/datasources/register_remote_data.dart';
import 'package:tradpool/features/register/data/models/create_user.dart';
import 'package:tradpool/features/register/domain/repositories/register_repository.dart';

typedef UserRegisterResponse = Future<String> Function();

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteData remoteData;
  final NetworkInf networkInfo;

  RegisterRepositoryImpl(this.networkInfo, this.remoteData);

  @override
  Future<Either<Failure, String>> createUser(CreateUserModel createUser) async {
    return await createtheuser(() {
      return remoteData.createuser(createUser);
    });
  }

  Future<Either<Failure, String>> createtheuser(
    UserRegisterResponse userRegisterResponse,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final createUserResponse = await userRegisterResponse();
        log(createUserResponse);
        return Right(createUserResponse);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}
