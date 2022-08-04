import 'package:tradpool/Core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/settings/data/model/preferences_body_model.dart';
import 'package:tradpool/features/settings/data/model/preferences_response_model.dart';
import 'package:tradpool/features/settings/data/remote_data/fill_user_preferences.dart';
import 'package:tradpool/features/settings/domain/repository/fill_user_preferences_repostory.dart';

class FillUserPreferencesRepositroyImp implements FillUserPreferencesRepositroy{
  final NetworkInf networkInf;
  final FillUserPreferencesRemoteData fillUserPreferencesRemoteData;

  FillUserPreferencesRepositroyImp(this.networkInf, this.fillUserPreferencesRemoteData);

  @override
  Future<Either<Failure, List<PreferencesResponseModel>>> userPreferences(String userId , List<PreferencesBodyRequestModel >preferencesBodyRequestModel) async {
       if (await networkInf.isConnected) {
      try {
        final response = await fillUserPreferencesRemoteData.fillUserPreferences(userId, preferencesBodyRequestModel);


        // ignore: void_checks
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}