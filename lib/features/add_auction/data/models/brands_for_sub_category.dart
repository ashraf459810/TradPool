// To parse this JSON data, do
//
//     final brandsForSubCategoryModel = brandsForSubCategoryModelFromJson(jsonString);

import 'dart:convert';

List<BrandsForSubCategoryModel> brandsForSubCategoryModelFromJson(String str) =>
    List<BrandsForSubCategoryModel>.from(
        json.decode(str).map((x) => BrandsForSubCategoryModel.fromJson(x)));

String brandsForSubCategoryModelToJson(List<BrandsForSubCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandsForSubCategoryModel {
  BrandsForSubCategoryModel({
    this.id,
    this.version,
    this.creationDate,
    this.lastModificationDate,
    this.uuid,
    this.objectType,
    this.attachments,
    this.name,
    this.code,
    this.enabled,
  });

  dynamic id;
  int version;
  DateTime creationDate;
  DateTime lastModificationDate;
  String uuid;
  String objectType;
  List<dynamic> attachments;
  String name;
  String code;
  bool enabled;

  factory BrandsForSubCategoryModel.fromJson(Map<String, dynamic> json) =>
      BrandsForSubCategoryModel(
        id: json["id"],
        version: json["version"],
        creationDate: DateTime.parse(json["creationDate"]),
        lastModificationDate: DateTime.parse(json["lastModificationDate"]),
        uuid: json["uuid"],
        objectType: json["objectType"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        name: json["name"],
        code: json["code"],
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "creationDate": creationDate.toIso8601String(),
        "lastModificationDate": lastModificationDate.toIso8601String(),
        "uuid": uuid,
        "objectType": objectType,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "name": name,
        "code": code,
        "enabled": enabled,
      };
}
