import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/settings/data/model/user_info_response_model.dart';

import 'package:tradpool/features/settings/domain/repository/fetch_user_preferences_repository.dart';



abstract class GetUserInfoUseCase {
  Future<Either<Failure,UserInfoResponseModel>> userInfo(String userID);
}


class GetUserInfoUseCaseImp implements GetUserInfoUseCase{
  final FetchUserpreferencesRepository fetchUserpreferencesRepository;

  GetUserInfoUseCaseImp(this.fetchUserpreferencesRepository);

  @override
  Future<Either<Failure, UserInfoResponseModel>> userInfo(String userID) async {
  return await fetchUserpreferencesRepository.userInfo(userID);
  }
}