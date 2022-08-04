import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/settings/data/model/preferences_body_model.dart';
import 'package:tradpool/features/settings/data/model/preferences_response_model.dart';

abstract class FillUserPreferencesRemoteData {
  Future<dynamic> fillUserPreferences(String userId ,List<PreferencesBodyRequestModel >preferencesBodyRequestModel);
}


class FillUserPreferencesRemoteDataImp implements FillUserPreferencesRemoteData {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf ;

  FillUserPreferencesRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future fillUserPreferences(String userId,List< PreferencesBodyRequestModel> preferencesBodyRequestModel) async {

    var response = await networkFunctions.postMethod(body: preferencesBodyRequestModelToJson(preferencesBodyRequestModel) ,
      url: '/tradepool/client/fill-preferences?client=$userId',baseurl: networkInf.baseUrl);
    return preferencesResponseModelFromJson(response);
    
  }
}