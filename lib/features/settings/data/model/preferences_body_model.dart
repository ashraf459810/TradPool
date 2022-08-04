// To parse this JSON data, do
//
//     final preferencesBodyRequestModel = preferencesBodyRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:tradpool/features/add_auction/data/models/brands_for_sub_category.dart';
import 'package:tradpool/features/add_auction/data/models/main_category.dart';
import 'package:tradpool/features/add_auction/data/models/sub_category.dart';

List<PreferencesBodyRequestModel> preferencesBodyRequestModelFromJson(String str) => List<PreferencesBodyRequestModel>.from(json.decode(str).map((x) => PreferencesBodyRequestModel.fromJson(x)));

String preferencesBodyRequestModelToJson(List<PreferencesBodyRequestModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PreferencesBodyRequestModel {
    PreferencesBodyRequestModel({
        this.mainCategory,
        this.data,
    });

    MainCategories mainCategory;
    List<Datum> data;

    factory PreferencesBodyRequestModel.fromJson(Map<String, dynamic> json) => PreferencesBodyRequestModel(
        mainCategory: MainCategories.fromJson(json["mainCategory"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCategory": mainCategory.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.subCategory,
        this.brands,
    });

    SubCategories subCategory;
    List<BrandsForSubCategoryModel> brands;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subCategory: SubCategories.fromJson(json["subCategory"]),
        brands: json["brands"] == null ? null : List<BrandsForSubCategoryModel>.from(json["brands"].map((x) => BrandsForSubCategoryModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "subCategory": subCategory.toJson(),
        "brands": brands == null ? null : List<dynamic>.from(brands.map((x) => x.toJson())),
    };
}


