import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/settings/data/model/support_user_request_model.dart';

abstract class UserSupportRequestRemoteData{

  Future<dynamic> getUserSupportRequest (String userId, String page , String size);


}

class UserSupportRequestRemoteDateImp implements UserSupportRequestRemoteData{
  final NetworkInf networkInf;
  final NetworkFunctions networkFunctions;

  UserSupportRequestRemoteDateImp(this.networkInf, this.networkFunctions);

  @override
  Future getUserSupportRequest(String userId, String page, String size) async {
    var response = await networkFunctions.getMethod(baseurl: networkInf.baseUrl, url: "/tradepool/client/get-requests-assistance?client=$userId&page=$page&size=$size");
   return supportRequestModelFromJson(response);

  }
}