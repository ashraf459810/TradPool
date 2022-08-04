import 'dart:developer';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/core/error/exceptions.dart';
import 'package:tradpool/core/network/network_info.dart';

import 'package:tradpool/features/verfication/data/models/verfication_model.dart';

import '../../../../injection_container.dart';

abstract class VerficationRemoteDate {
  Future<VerificationResponse> verficationcode(String mobile, String code);
}

class VerficationRemoteDataImpl implements VerficationRemoteDate {
  final Client client;
  NetworkInfImpl networkInf = NetworkInfImpl();

  VerficationRemoteDataImpl(
    this.client,
  );
  @override
  Future<VerificationResponse> verficationcode(String mobile, String code) {
    return verifyUserFromUrl(mobile, code, networkInf.baseurl);
  }

  Future<VerificationResponse> verifyUserFromUrl(
      String mobile, String code, String url) async {
    final response = await client.get(
      Uri.parse(
          url + "/tradepool/client/check-otp?code=$code&mobileNumber=$mobile"),
      headers: {
        'Content-Type': 'application/json',
              'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log('200');
      return verificationResponseFromJson(response.body);
    }
    if (response.statusCode == 500) {
      log("500");

      return null;
    } else {
      throw ServerException();
    }
  }
}
