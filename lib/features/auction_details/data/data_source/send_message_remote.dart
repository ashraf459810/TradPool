import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';

import 'package:tradpool/features/auction_details/data/model/messages_request_body.dart';

abstract class SendMessageRemoteData {
  Future<dynamic> sendMessage (MessageRequestBody messageModel);
}



class SendMessageRemoteDataImp implements SendMessageRemoteData{
  final NetworkInf networkInf;
  final NetworkFunctions networkFunctions;

  SendMessageRemoteDataImp(this.networkInf, this.networkFunctions);

  @override
  Future sendMessage(MessageRequestBody messageModel) async {
  
    var response= await networkFunctions.postMethod(url: '/tradepool/buy-and-sell/send-msg',baseurl: networkInf.baseUrl ,body: messageRequestBodyToJson(messageModel));
    return Message.fromJson(response);
    


  }
  
} 