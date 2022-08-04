import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/settings/data/model/preferences_body_model.dart';
import 'package:tradpool/features/settings/data/model/preferences_response_model.dart';

abstract class FillUserPreferencesRepositroy {
  Future<Either<Failure,List<PreferencesResponseModel >>> userPreferences(String userId , List<PreferencesBodyRequestModel >preferencesBodyRequestModel);
}

