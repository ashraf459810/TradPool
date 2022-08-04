

import 'package:dartz/dartz.dart';
import 'package:tradpool/features/settings/domain/repository/user_history_repository.dart';

import '../../../../Core/error/failures.dart';
import '../../data/model/user_history_model.dart';

abstract class UserHistoryUseCase {
  Future<Either<Failure,UserHistoryModel>> userHistoryUseCase (String auctuonId, String page , String size);
}

class UserHistoryUseCaseImp implements UserHistoryUseCase {
  final UserHistoryRepository userHistoryRepository;

  UserHistoryUseCaseImp(this.userHistoryRepository);

  @override
  Future<Either<Failure, UserHistoryModel>> userHistoryUseCase(String auctuonId, String page, String size) async {
    return await userHistoryRepository.userHistory(auctuonId, page, size);
  }
}