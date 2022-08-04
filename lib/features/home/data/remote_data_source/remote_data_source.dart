import 'dart:developer';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/core/error/exceptions.dart';
import 'package:tradpool/core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/home/data/model/all_auctions_model.dart';

import '../../../../injection_container.dart';

abstract class AllAuctionsRemoteData {
  Future<AllAuctionsModel> getAllAuctions(int page, int size);
}

class AllAuctionsRemoteDataImp implements AllAuctionsRemoteData {
  final Client client;
  final NetworkInf networkInf;
  NetworkFunctions networkFunctions;

  AllAuctionsRemoteDataImp(this.client, this.networkInf);

  @override
  Future<AllAuctionsModel> getAllAuctions(int page, int size) async {
    final response = await client.get(
      Uri.parse(networkInf.baseUrl +
          "/tradepool/buy-and-sell/get-auctions?page=$page&size=$size"), 
      headers: {
        'Content-Type': 'application/json',
              'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',
      },
    );

    if (response.statusCode == 200) {
      log("200");
      return allAuctionsModelFromJson(response.body);
    } else {
      throw ServerException();
    }

  }
}
