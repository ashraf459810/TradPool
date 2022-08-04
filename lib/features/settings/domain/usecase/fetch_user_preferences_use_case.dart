import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';

import 'package:tradpool/features/settings/domain/repository/fetch_user_preferences_repository.dart';

import '../../data/model/user_preferences_model.dart';

abstract class FetchUserPreferencesUseCase {
  Future<Either<Failure,List<UserPreferencesModel>>> fetchUserPreferencesUseCase(String userID);
}


class FetchUserPreferencesUseCaseImp implements FetchUserPreferencesUseCase{
  final FetchUserpreferencesRepository fetchUserpreferencesRepository;

  FetchUserPreferencesUseCaseImp(this.fetchUserpreferencesRepository);

  @override
  Future<Either<Failure, List<UserPreferencesModel>>> fetchUserPreferencesUseCase(String userID) async {
  return await fetchUserpreferencesRepository.fetchUserPreferences(userID);
  }
}