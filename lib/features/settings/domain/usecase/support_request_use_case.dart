import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/settings/data/model/support_user_request_model.dart';

import '../repository/support_requests_repository.dart';

abstract class SupportRequestUseCase {
  Future<Either<Failure,SupportRequestModel >> supportRequestUseCase (String userId, String page , String size);
}


class SupportRequestUseCaseImp implements SupportRequestUseCase{
  final SupportRequestRepository supportRequestRepository;

  SupportRequestUseCaseImp(this.supportRequestRepository);

  @override
  Future<Either<Failure, SupportRequestModel>> supportRequestUseCase(String userId, String page, String size) async {
    return await supportRequestRepository.supportRequestRepostiry(userId, page, size);
  }
}