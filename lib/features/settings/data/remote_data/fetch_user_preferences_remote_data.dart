import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/settings/data/model/update_user_model.dart';

import 'package:tradpool/features/settings/data/model/user_preferences_model.dart';

import '../model/user_info_response_model.dart';

abstract class FetchUserPreferencesRemoeData {
    Future<dynamic> updateUserInfo (UpdateUserBody updateUserBody);
  Future<dynamic> fetchUserPreferences (String userId);
    Future<dynamic> userInfo (String token);
}


class FetchUserPreferencesRemoteDataImp implements FetchUserPreferencesRemoeData{
  final NetworkInf networkInf;
  final NetworkFunctions networkFunctions;

  FetchUserPreferencesRemoteDataImp(this.networkInf, this.networkFunctions);

  @override
  Future fetchUserPreferences(String userId) async {
    var response= await networkFunctions.getMethod(baseurl: networkInf.baseUrl,url: "/tradepool/client/get-preferences?client=$userId");
    return userPreferencesModelFromJson(response);
  }

  @override
  Future userInfo(String token) async {
    var response= await networkFunctions.getMethod(url: "/tradepool/client/get?client=$token",baseurl: networkInf.baseUrl);
    return userInfoResponseModelFromJson(response);
  }

  @override
  Future updateUserInfo(UpdateUserBody updateUserBody )async {

       var response= await networkFunctions.postMethod(url: "/tradepool/client/update",baseurl: networkInf.baseUrl,body: updateUserBodyToJson(updateUserBody));
      
    return   response;
  }
  
}

