import 'package:http/http.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';

abstract class FetchUserNotificationRemoteData {
  Future<dynamic> fetchUserNotification(String clientId, int page, int size);
  Future<dynamic> markNotificationSeen(String notificationId);
}

class FetchUserNotificationRemoteDataImp
    implements FetchUserNotificationRemoteData {
  final Client client;
  final NetworkInf networkInf;

  FetchUserNotificationRemoteDataImp(this.client, this.networkInf);

  @override
  Future<dynamic> fetchUserNotification(
      String clientId, int page, int size) async {
    NetworkFunctionsImp networkFunctions = NetworkFunctionsImp();
    return await networkFunctions.getMethod(
        baseurl: networkInf.baseUrl,
        url:
            '/tradepool/client/get-notifications?client=$clientId&page=$page&size=$size');
  }

  @override
  Future markNotificationSeen(String notificationId) async {

    NetworkFunctionsImp networkFunctions = NetworkFunctionsImp();
    return await networkFunctions.postMethod(
        baseurl: networkInf.baseUrl,
        url: "/tradepool/helper/mark-notification-as-read?notification=$notificationId");
  }
}
