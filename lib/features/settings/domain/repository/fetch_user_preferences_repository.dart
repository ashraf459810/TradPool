import 'package:dartz/dartz.dart';
import 'package:tradpool/Core/error/failures.dart';
import 'package:tradpool/features/settings/data/model/update_user_model.dart';
import 'package:tradpool/features/settings/data/model/user_info_response_model.dart';



import '../../data/model/user_preferences_model.dart';

abstract class FetchUserpreferencesRepository {
  Future<Either<Failure,List<UserPreferencesModel>>> fetchUserPreferences(String userId);
    Future<Either<Failure,UserInfoResponseModel>> userInfo(String userId);
        Future<Either<Failure,String>> updateuserInfo(UpdateUserBody updateUserBody);
}


