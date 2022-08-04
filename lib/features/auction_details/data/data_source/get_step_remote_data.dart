import 'dart:convert';

import 'package:http/http.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';

abstract class GetStepRemoteData {
  Future<dynamic> getStep(String auctionId);
}

class GetStepRemoteDataImpl implements GetStepRemoteData {
  final NetworkInf networkInf;
  final Client client;

  GetStepRemoteDataImpl(this.networkInf, this.client);

  @override
  Future<dynamic> getStep(String auctionId) async {
    NetworkFunctionsImp networkFunctions = NetworkFunctionsImp();

    var response = await networkFunctions.getMethod(
        baseurl: networkInf.baseUrl,
        url:
            "/tradepool/buy-and-sell/get-next-bid-price?sellRequest=$auctionId");

            return json.decode(response) ;
  }
}
