import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/core/error/exceptions.dart';
import 'package:http/http.dart' as http;

import '../../injection_container.dart';

abstract class NetworkFunctions {
  Future<dynamic> getMethod({String url, String baseurl});
  Future<dynamic> postMethod({String url, String baseurl, dynamic body});
}

class NetworkFunctionsImp implements NetworkFunctions {
 final http.Client client = http.Client();
  @override
  Future<dynamic> getMethod({String url, String baseurl}) async {
    final response = await client.get(
      Uri.parse(baseurl + url),
      headers: {
        'Content-Type': 'application/json'  ,
              'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',
      },
    );
    log(baseurl + url);
    log(response.body);
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
    } 
     if (response.statusCode == 400) {
    
    
      throw ServerException(
       '400'
      );
    } 

    else {
      throw ServerException("No Internet");
    }
  }

  @override
  Future postMethod({String url, String baseurl, body}) async {
    final response = await client.post(Uri.parse(baseurl + url),
        headers: {
          'Content-Type': 'application/json',
                'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',
        },
        body: body );
    log(baseurl + url);
    log(response.body);

    if (response.statusCode == 200) {
      log("200 from remote data source");
      return response.body;
    }
    if (response.statusCode == 500) {
      var res = json.decode(response.body);
      log(res["message"]);
      log("500 here");
      log(response.body);
      throw ServerException(
        res["message"],
      );
    } else {
      throw ServerException();
    }
  }
}
