import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';

import '../../data/model/support_request_model.dart';

abstract class SupportRequestDetailsRepository {
  Future<Either<Failure, SupportRequestDetailsModel>>supporRequestDetailsRepository (String userId , String requestId);
}

