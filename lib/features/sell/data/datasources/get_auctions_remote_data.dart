import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/core/error/exceptions.dart';
import 'package:tradpool/Core/network/network_info.dart';

import 'package:tradpool/features/sell/data/models/all_auctions_model.dart';

import '../../../../injection_container.dart';

abstract class UserAuctionsRemoteData {
  Future<UserAuctionsModel> getAuctions(int page, int size, String usertoken);
}

class UserAuctionsRmoteDataImpl implements UserAuctionsRemoteData {
  final Client client;
  final NetworkInf networkInf;

  UserAuctionsRmoteDataImpl(this.client, this.networkInf);

  @override
  Future<UserAuctionsModel> getAuctions(
      int page, int size, String userToken) async {
    final response = await client.get(
      Uri.parse(networkInf.baseUrl +
          "/tradepool/buy-and-sell/get-auctions-by-seller?seller=$userToken&page=$page&size=$size"),
          headers: {      'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',}
    );

    log(response.statusCode.toString());
    log(networkInf.baseUrl +
        "/tradepool/buy-and-sell/get-auctions-by-seller?seller=$userToken&page=$page&size=$size");
    if (response.statusCode == 200) {
      log("200");

      return userAuctionsModelFromJson(response.body);
    }
    if (response.statusCode == 500) {
      log("500");
      var error = jsonDecode(response.body);
      throw ServerException(error["message"]);
    } else {
      throw ServerException();
    }
  }
}
