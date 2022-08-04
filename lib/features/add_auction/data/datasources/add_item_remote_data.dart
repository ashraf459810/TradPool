import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/core/error/exceptions.dart';
import 'package:tradpool/features/add_auction/data/models/add_file_response.dart';
import 'package:tradpool/features/add_auction/data/models/auction_body.dart';
import 'package:tradpool/features/add_auction/data/models/brands_for_sub_category.dart';
import 'package:tradpool/features/add_auction/data/models/calculate_response_model.dart';
import 'package:tradpool/features/add_auction/data/models/main_category.dart';
import 'package:tradpool/features/add_auction/data/models/sub_category.dart';

import '../../../../injection_container.dart';

abstract class AddItemRemoteData {

  Future<List<MainCategories>> getCategory();
  Future<List<AddFileResponse>> uploadFile({String tag, List<XFile> image});
  Future<List<SubCategories>> getSubCategory(String maincategoryid);
  Future<String> addAuction(AuctionBody auctionBody ,String imageId , String address);
    Future<CalculateResponseModel> calculateAuction(AuctionBody auctionBody);
  Future<List<BrandsForSubCategoryModel>> getbrands(String subCategoryid);
}

class AddItemRemoteDataImp implements AddItemRemoteData {
  final http.Client client;
  NetworkInfImpl networkInf = NetworkInfImpl();

  AddItemRemoteDataImp(
    this.client,
  );
  @override
  Future<List<MainCategories>> getCategory() async {

    final response = await client.get(
      Uri.parse(networkInf.baseurl +
          "/tradepool/helper/get-list-items?code=main_categories"),
      headers: {
        'Content-Type': 'application/json',
         'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',
      },
    );

    if (response.statusCode == 200) {
      log("200");

      return mainCategoriesFromJson(response.body);
    }
    if (response.statusCode == 500) {
      log("500");
      var error = jsonDecode(response.body);
      throw ServerException(error["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SubCategories>> getSubCategory(String maincategoryid) async {
    final response = await client.get(
      Uri.parse(networkInf.baseurl +
          "/tradepool/helper/get-pick-list-items?parent=$maincategoryid"),
      headers: {
        'Content-Type': 'application/json',
                 'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',
      },
    );
    log(networkInf.baseurl +
        "/tradepool/helper/get-pick-list-items?parent=$maincategoryid");
    if (response.statusCode == 200) {
      log("200");
      return subCategoriesFromJson(response.body);
    }
    if (response.statusCode == 500) {
      log("500");
      var error = jsonDecode(response.body);
      throw ServerException(error["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> addAuction(AuctionBody auctionBody,String imageId , String address) async {
    log(auctionBodyToJson(auctionBody));
    final response = await client.post(
        Uri.parse(
            networkInf.baseurl + "/tradepool/buy-and-sell/create-sell-request?clientId=$imageId&address=$address"),
        headers: {
          'Content-Type': 'application/json',         'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',
        },
        body: auctionBodyToJson(auctionBody));

    if (response.statusCode == 200) {
      log("200");
      return response.body;
    }
    if (response.statusCode == 500) {
      log("500");
      var error = jsonDecode(response.body);
      throw ServerException(error["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<BrandsForSubCategoryModel>> getbrands(
      String subCategoryid) async {
    final response = await client.get(
      Uri.parse(networkInf.baseurl +
          "/tradepool/helper/get-pick-list-items?parent=$subCategoryid"),
      headers: {
        'Content-Type': 'application/json',         'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',
      },
    );

    if (response.statusCode == 200) {
      log("200");
      return brandsForSubCategoryModelFromJson(response.body);
    } else if (response.statusCode == 500) {
      var error = jsonDecode(response.body);
      throw ServerException(error["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<AddFileResponse>> uploadFile(
      {String tag, List<XFile> image}) async {
    List<AddFileResponse> imagesResponse = [];

    var link = "/tradepool/storage/uploadfiles?tag=$tag";

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(networkInf.baseurl + link ,),);


    for (int i = 0; i < image.length; i++) {
      var pic = await http.MultipartFile.fromPath("files", image[i].path);

      request.files.add(pic);
    }
    request.headers.addAll({      'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',});

    final response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) {

      imagesResponse.addAll(addFileResponseFromJson(value));
    });

    log(response.statusCode.toString());


    if (response.statusCode == 200) {
      return imagesResponse;
    }
    if (response.statusCode == 500) {
      throw ServerException("Error while downloading");
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<CalculateResponseModel> calculateAuction(AuctionBody auctionBody) async {
        log(auctionBodyToJson(auctionBody));
    final response = await client.post(
        Uri.parse(
            networkInf.baseurl + "/tradepool/buy-and-sell/calculate-and-validate-ad"),
        headers: {
          'Content-Type': 'application/json',
                   'Authorization': 'Bearer ${sl<SharedPreferences>().getString("Auth")}',
        },
        body: auctionBodyToJson(auctionBody));

    if (response.statusCode == 200) {
      log("200");
      log(response.body);
      return  calculateResponseModelFromJson( response.body);
    }
    if (response.statusCode == 500) {
      log(response.body);
      log("500");
      var error = json.decode(response.body);
      log(error );

    var res = json.decode(response.body);
 
      throw ServerException(res["message"]);
    } else {
      throw ServerException("Server Error");
    }
   
  }
}

class ImagesParams {
  dynamic name;
  dynamic image;

  ImagesParams(this.name, this.image);
}
