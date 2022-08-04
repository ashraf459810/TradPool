// To parse this JSON data, do
//
//     final userPreferencesModel = userPreferencesModelFromJson(jsonString);

import 'dart:convert';

List<UserPreferencesModel> userPreferencesModelFromJson(String str) => List<UserPreferencesModel>.from(json.decode(str).map((x) => UserPreferencesModel.fromJson(x)));

String userPreferencesModelToJson(List<UserPreferencesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserPreferencesModel {
    UserPreferencesModel({
        this.mainCategory,
        this.data,
    });

    MainCategory mainCategory;
    List<Datum> data;

    factory UserPreferencesModel.fromJson(Map<String, dynamic> json) => UserPreferencesModel(
        mainCategory: MainCategory.fromJson(json["mainCategory"]),
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

    MainCategory subCategory;
    List<MainCategory> brands;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subCategory: MainCategory.fromJson(json["subCategory"]),
        brands: json["brands"] == null ? null : List<MainCategory>.from(json["brands"].map((x) => MainCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "subCategory": subCategory.toJson(),
        "brands": brands == null ? null : List<dynamic>.from(brands.map((x) => x.toJson())),
    };
}

class MainCategory {
    MainCategory({
        this.id,
        this.code,
        this.name,
    });

    String id;
    String code;
    String name;

    factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
        id: json["id"],
        code: json["code"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
    };
}
