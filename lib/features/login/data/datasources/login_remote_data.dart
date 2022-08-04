import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/Core/error/exceptions.dart';
import 'package:tradpool/Core/network/network_info.dart';

import '../../../../injection_container.dart';

abstract class LoginRemoteDate {
  Future<String> login(String number);
}

class LoginRemoteDateImp implements LoginRemoteDate {
  NetworkInfImpl networkInfo = NetworkInfImpl();
  final Client client;

  LoginRemoteDateImp(this.client);
  @override
  Future<String> login(String mobile) {
    return loginfromurl(networkInfo.baseurl, mobile);
  }

  Future<String> loginfromurl(String url, String mobile) async {
    final response = await client.post(
      Uri.parse(url + "/tradepool/client/login?mobileNumber=$mobile"),
      headers: {
        'Content-Type': 'application/json',
              'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',
      },
    );

    if (response.statusCode == 200) {
      log("200");
      return response.body;
    }
    if (response.statusCode == 500) {
      var res = json.decode(response.body);
      log(res["message"]);
      log("500 here");
      throw ServerException(
        res["message"],
      );
    } else {
      throw ServerException();
    }
  }
}
