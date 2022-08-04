import 'package:http/http.dart';
import 'package:tradpool/core/remote_data_function/http_methods.dart';
import 'package:tradpool/Core/network/network_info.dart';

abstract class AutoBidRemoteData {
  Future<void> autoBidRemoteData(
      String clientId, String maxPrice, String auctionID);
}

class AutoBidRemoteDataImp implements AutoBidRemoteData {
  final Client client;
  final NetworkInf networkInf;

  AutoBidRemoteDataImp(this.client, this.networkInf);

  @override
  Future<void> autoBidRemoteData(
      String clientId, String maxPrice, String auctionID) async {
    NetworkFunctionsImp networkFunctionsImp = NetworkFunctionsImp();
    return await networkFunctionsImp.postMethod(
        baseurl: networkInf.baseUrl,
        url:
            '/tradepool/buy-and-sell/enable-auto-bidder?sellRequest=$auctionID&maxPrice=$maxPrice&bidder=$clientId');
  }
}
