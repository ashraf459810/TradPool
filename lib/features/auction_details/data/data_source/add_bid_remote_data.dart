import 'dart:developer';

import 'package:http/http.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/auction_details/data/model/add_bid_response.dart';

abstract class AddBidRemoteDate {
  Future<AddBidResponse> addBid(
      String auctionId, int price, String userID);
}

class AddBidRemoteDataImp implements AddBidRemoteDate {
  final Client client;
  final NetworkInf networkInf;

  AddBidRemoteDataImp(this.client, this.networkInf);

  @override
  Future<AddBidResponse> addBid(
      String auctionId, int price, String userID) async {
    log(networkInf.baseUrl +
        "/tradepool/buy-and-sell/add-bid-request?sellRequest=$auctionId&price=$price&bidder=$userID");
    NetworkFunctionsImp networkFunctions = NetworkFunctionsImp();

    var result = await networkFunctions.getMethod(
        baseurl: networkInf.baseUrl,
        url:
            "/tradepool/buy-and-sell/add-bid-request?sellRequest=$auctionId&price=$price&bidder=$userID");

    return addBidResponseFromJson(result);
  }
}
