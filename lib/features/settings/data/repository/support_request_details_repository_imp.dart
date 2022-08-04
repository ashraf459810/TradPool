import 'package:tradpool/features/settings/data/model/support_request_model.dart';

import 'package:dartz/dartz.dart';
import 'package:tradpool/features/settings/data/remote_data/support_request_details.dart';
import 'package:tradpool/features/settings/domain/repository/support_request_details_repository.dart';

import '../../../../Core/error/failures.dart';
import '../../../../Core/network/network_info.dart';

class SupportRequestDetailsRepostiryImp implements SupportRequestDetailsRepository {
  final SupportRequestDetailsRemoteDate supportRequestDetailsRemoteDate;
  final NetworkInf networkInf;

  SupportRequestDetailsRepostiryImp(this.supportRequestDetailsRemoteDate, this.networkInf);

  @override
  Future<Either<Failure, SupportRequestDetailsModel>> supporRequestDetailsRepository(String userId, String requestId) async {
           if (await networkInf.isConnected) {
      // try {
        final response = await supportRequestDetailsRemoteDate.supportRequestDetails(userId, requestId);


        // ignore: void_checks
        return Right(response);
      // } catch (e) {
      //   return Left(ServerFailure(e.error));
      // }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}