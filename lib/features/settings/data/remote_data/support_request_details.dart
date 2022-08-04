import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/settings/data/model/support_request_model.dart';

import '../../../../Core/network/network_info.dart';

abstract class SupportRequestDetailsRemoteDate {
  Future<dynamic> supportRequestDetails (String userId , String requestId);
}

class SupportRequestDetailsRemoteDateImp implements SupportRequestDetailsRemoteDate {
  final NetworkInf networkInf;
  final NetworkFunctions networkFunctions;

  SupportRequestDetailsRemoteDateImp(this.networkInf, this.networkFunctions);

  @override
  Future supportRequestDetails(String userId, String requestId) async {
     var response = await networkFunctions.getMethod(baseurl:  networkInf.baseUrl, url:  '/tradepool/client/get-request-assistance-details?user=$userId&requestAssistance=$requestId');
     return supportRequestDetailsModelFromJson(response);
  }
  
}