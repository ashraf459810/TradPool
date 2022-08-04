import 'package:tradpool/core/error/exceptions.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/verfication/data/datasources/verfication_local_data.dart';

import 'package:tradpool/features/verfication/data/datasources/verfication_remote_data.dart';
import 'package:tradpool/features/verfication/data/models/verfication_model.dart';
import 'package:tradpool/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/features/verfication/domain/repositories/verfication_repository.dart';

typedef VerficationRes = Future<VerificationResponse> Function();

class VerficationRepositoryImp implements VerficationRepository {
  final VerficationRemoteDate verficationRemoteDate;
  final NetworkInf networkInfo;

  final VerficationLocatData verficationLocatData;

  VerficationRepositoryImp(
      this.verficationRemoteDate, this.networkInfo, this.verficationLocatData);

  @override
  Future<Either<Failure, VerificationResponse>> checkcode(
      String mobile, String code) async {
    return await verfiy(() {
      return verficationRemoteDate.verficationcode(mobile, code);
    });
  }

  Future<Either<Failure, VerificationResponse>> verfiy(
    VerficationRes userverifcationresponse,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await userverifcationresponse();
        if (result != null) {
          verficationLocatData.saveToken(result.id.toString());
          verficationLocatData.setUserverfiy(true);
        }
        return Right((result));
      } on ServerException {
        return Left(ServerFailure(ServerException().error));
      } catch (e) {
        rethrow;
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }

  @override
  Future<bool> getIsVerify() async {
    return await verficationLocatData.getIfUserverfiy();
  }

  @override
  Future<String> getToken() async {
    return await verficationLocatData.getToken();
  }

  @override
  Future<void> setIsVerify(bool value) async {
    return await verficationLocatData.setUserverfiy(value);
  }

  @override
  Future<void> setToken(String token) async {
    return await verficationLocatData.saveToken(token);
  }
}
