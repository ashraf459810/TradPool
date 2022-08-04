import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/settings/data/model/support_user_request_model.dart';

abstract class SupportRequestRepository {
  Future<Either<Failure,SupportRequestModel >> supportRequestRepostiry (String userId, String page , String size);
}