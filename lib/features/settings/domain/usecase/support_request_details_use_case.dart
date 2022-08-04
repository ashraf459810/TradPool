
import 'package:dartz/dartz.dart';
import 'package:tradpool/features/settings/domain/repository/support_request_details_repository.dart';

import '../../../../Core/error/failures.dart';
import '../../data/model/support_request_model.dart';


abstract class SupportRequestDetailsUseCase {
  Future<Either<Failure,SupportRequestDetailsModel>>supportRequestDetailsUseCase(String userId , String requestID);
  
}


class SupportRequestDetailsUseCaseImp implements SupportRequestDetailsUseCase{
  final SupportRequestDetailsRepository supportRequestDetailsRepository;

  SupportRequestDetailsUseCaseImp(this.supportRequestDetailsRepository);

  @override
  Future<Either<Failure, SupportRequestDetailsModel>> supportRequestDetailsUseCase(String userId, String requestID) async {
   return await supportRequestDetailsRepository.supporRequestDetailsRepository(userId, requestID);
  }

 

}