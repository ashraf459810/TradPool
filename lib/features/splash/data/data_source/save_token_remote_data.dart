import 'package:http/http.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/core/remote_data_function/http_methods.dart';

abstract class SaveFireBaseTokenRemoteDate {
  Future<void> saveFcmToken(String token, String fcmToken);
}

class SaveFireBaseTokenRemoteDateImp implements SaveFireBaseTokenRemoteDate {
  final Client client;
  final NetworkInf networkInf;

  SaveFireBaseTokenRemoteDateImp(this.client, this.networkInf);

  @override
  Future<void> saveFcmToken(String token, String fcmToken) async {
    NetworkFunctionsImp networkFunctions = NetworkFunctionsImp();

    return await networkFunctions.postMethod(
        body: null,
        baseurl: networkInf.baseUrl,
        url:
            "/tradepool/client/savefirebasetoken?client=$token&token=$fcmToken&type=MOBILE");
  }
}
