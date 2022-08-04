import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/Core/error/exceptions.dart';
import 'package:tradpool/Core/network/network_info.dart';

import 'package:tradpool/features/register/data/models/create_user.dart';
import 'package:http/http.dart' as http;

import '../../../../injection_container.dart';

abstract class RegisterRemoteData {
  Future<String> createuser(CreateUserModel createUser);
}

class RegisterRemoteDateImpl implements RegisterRemoteData {
  NetworkInfImpl networkInfo = NetworkInfImpl();
  final http.Client client;

  RegisterRemoteDateImpl(this.client);
  @override
  Future<String> createuser(CreateUserModel createUser) {
    return createUserFromUrl(networkInfo.baseurl, createUser);
  }

  Future<String> createUserFromUrl(
      String url, CreateUserModel createUser) async {
    log(createUserToJson(createUser));
    final response =
        await client.post(Uri.parse(url + "/tradepool/client/create"),
            headers: {
              'Content-Type': 'application/json',
                    'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',
            },
            body: createUserToJson(createUser));
    log(response.body);
    if (response.statusCode == 200) {
      log("200");
      return response.body;
    }
    if (response.statusCode == 500) {
      log("500");
      var res = json.decode(response.body);
      throw ServerException(res["message"]);
    } else {
      throw ServerException();
    }
  }
}
