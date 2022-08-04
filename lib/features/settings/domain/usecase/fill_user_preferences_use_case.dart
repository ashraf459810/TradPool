import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/settings/data/model/preferences_body_model.dart';
import 'package:tradpool/features/settings/data/model/preferences_response_model.dart';
import 'package:tradpool/features/settings/domain/repository/fill_user_preferences_repostory.dart';

abstract class FillUserPreferencesUseCase {

  Future<Either<Failure,List<PreferencesResponseModel>>>fillUserPreferencesUseCase(String userId , List<PreferencesBodyRequestModel> preferencesBodyRequestModel);
}


class FillUserPreferencesUseCaseImp implements FillUserPreferencesUseCase {
  final FillUserPreferencesRepositroy fillUserPreferencesRepositroy;

  FillUserPreferencesUseCaseImp(this.fillUserPreferencesRepositroy);

  @override
  Future<Either<Failure, List<PreferencesResponseModel>>> fillUserPreferencesUseCase(String userId,List< PreferencesBodyRequestModel> preferencesBodyRequestModel) async{
    return await fillUserPreferencesRepositroy.userPreferences(userId,preferencesBodyRequestModel);
  }
}