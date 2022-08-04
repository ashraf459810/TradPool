import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';

abstract class CreateSupportRequestRemoteData {
  Future<dynamic> createSupportRequest (String userId , String supportId , String text);
}


class CreateSupportRequestRemoteDataImp implements CreateSupportRequestRemoteData {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  CreateSupportRequestRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future createSupportRequest(String userId, String supportId, String text) {
  var respoinse=  networkFunctions.postMethod(url: '/tradepool/client/create-request-assistance?client=$userId&text=$text&type=$supportId',baseurl: networkInf.baseUrl);
    return respoinse;
  }

}