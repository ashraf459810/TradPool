
import 'dart:convert';
import 'dart:developer';



import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';

import '../app_excepition.dart';
import 'http_interface.dart';



class HttpImplement implements HttpInterface {
  final Client client;
  final String _baseUrl =  "https://tradpool.com";
  // "159.223.143.45:8080";
  // "http://159.89.51.204:8080";

  HttpImplement(this.client);
  @override
  Future getrequest(String url) async {
    dynamic responseJson;

    var connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        throw NoInternet("No Internet");
     
    }

    final response = await client.get(Uri.parse(_baseUrl + url,));

    log("here from http $url");
    log(response.body);
    log(response.statusCode.toString());
    responseJson = returnResponse(response);

    return responseJson;
  }

  @override
  Future postrequest(String url, body) async {
    dynamic responseJson;
    var connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        throw NoInternet("");

        break;
    }

    final response = await client.post(
        Uri.parse(
          _baseUrl + url,
        ),
        body: body);
    log("here from http $url");
    log(response.body);
    log(response.statusCode.toString());
    responseJson = returnResponse(response);

    return responseJson;
  }

  @override
  returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseinjson = (response.body);


        return responseinjson;
        

      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        log("error");
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw NoInternet("Url Not Found");
      case 500:
              var responseinjson = (response.body);
              
      var res = json.decode(responseinjson)["message"];
        throw InternalServerError(res);

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
  
  @override
  Future putrequest(String url, body)async{
       dynamic responseJson;
    var connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        throw NoInternet("");

        break;
    }

    final response = await client.put(
        Uri.parse(
          _baseUrl + url,
        ),
        body: body);
    log("here from http $url");
    log(response.body);
    log(response.statusCode.toString());
    responseJson = returnResponse(response);

    return responseJson;
  }
  

}
