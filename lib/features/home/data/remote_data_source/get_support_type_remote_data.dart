import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/home/data/model/support_type_model.dart';

abstract class SupportTypeRemoteData {
  Future<dynamic> getSupportType (String code);
}


class SupportTypeRemoteDataImp implements SupportTypeRemoteData {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  SupportTypeRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future getSupportType(String code) async {
    var response = await networkFunctions.getMethod(url: '/tradepool/helper/get-list-items?code=$code',baseurl: networkInf.baseUrl);
    return supportTypeModelFromJson(response);
  }
}