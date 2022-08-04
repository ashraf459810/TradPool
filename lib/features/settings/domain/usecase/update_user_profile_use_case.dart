import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/settings/data/model/update_user_model.dart';


import 'package:tradpool/features/settings/domain/repository/fetch_user_preferences_repository.dart';


abstract class UpdateUserInfoUseCase {
  Future<Either<Failure,String>> updateProfileUseCase(UpdateUserBody updateUserBody);
}


class UpdateInfoUseCaseImp implements UpdateUserInfoUseCase{
  final FetchUserpreferencesRepository fetchUserpreferencesRepository;

  UpdateInfoUseCaseImp(this.fetchUserpreferencesRepository);

  @override
  Future<Either<Failure, String>> updateProfileUseCase(UpdateUserBody updateUserBody) async {
  return await fetchUserpreferencesRepository.updateuserInfo(updateUserBody);
  }
}