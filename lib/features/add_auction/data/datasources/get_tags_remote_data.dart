import 'dart:convert';

import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';

abstract class GetTagsRemoteData {
  Future<dynamic> getTags(String categoryId);
}

class GetTagsRmoteDataImp implements GetTagsRemoteData {
  final NetworkInf networkInf;
  final NetworkFunctions networkFunctions;

  GetTagsRmoteDataImp(this.networkInf, this.networkFunctions);

  @override
  Future getTags(String categoryId) async {
   var response= await networkFunctions.getMethod(baseurl: networkInf.baseUrl,url: "/tradepool/helper/get-category-tags?category=$categoryId");
   return tagsModelFromJson(response);
  }
  
}



List<String> tagsModelFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String tagsModelToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
