import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/settings/data/model/user_history_model.dart';

abstract class UserHistoryRemoteData {
  Future<dynamic> userHistory (String requesId , String page, String size);
}


class UserHistoryRemoteDataImp implements UserHistoryRemoteData{
  final NetworkInf networkInf;
  final NetworkFunctions networkFunctions;

  UserHistoryRemoteDataImp(this.networkInf, this.networkFunctions);

  @override
  Future userHistory(String auctionId, String page, String size) async{
    var response= await networkFunctions.getMethod(baseurl: networkInf.baseUrl,url: "/tradepool/buy-and-sell/get-client-sell-history?sellRequest=$auctionId&page=$page&size=$size");
    return userHistoryModelFromJson(response);
  }
}