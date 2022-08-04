import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/settings/data/model/user_history_model.dart';

abstract class UserHistoryRepository {
  Future<Either<Failure,UserHistoryModel>>userHistory(String auctionId,String page, String size);
}