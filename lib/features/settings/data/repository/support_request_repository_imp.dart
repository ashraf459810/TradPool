import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/settings/data/model/support_user_request_model.dart';

import 'package:tradpool/features/settings/data/remote_data/get_user_support_request.dart';

import '../../domain/repository/support_requests_repository.dart';

class SupportRequestRepositoryImp implements SupportRequestRepository {
  final NetworkInf networkInf;
  final UserSupportRequestRemoteData userSupportRequestRemoteData;

  SupportRequestRepositoryImp(this.networkInf, this.userSupportRequestRemoteData);

  @override
  Future<Either<Failure, SupportRequestModel>> supportRequestRepostiry(String userId, String page, String size) async {
   
         if (await networkInf.isConnected) {
      try {
        final response = await userSupportRequestRemoteData.getUserSupportRequest(userId, page, size);


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