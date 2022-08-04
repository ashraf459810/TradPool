// To parse this JSON data, do
//
//     final mainCategories = mainCategoriesFromJson(jsonString);

import 'dart:convert';

List<MainCategories> mainCategoriesFromJson(String str) =>
    List<MainCategories>.from(
        json.decode(str).map((x) => MainCategories.fromJson(x)));

String mainCategoriesToJson(List<MainCategories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainCategories {
  MainCategories({
    this.adCost,
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
    this.additionalField,
    this.arabicName
  });

  String id;
  int adCost;
  int version;
  String arabicName;
  DateTime creationDate;
  DateTime lastModificationDate;
  String uuid;
  String objectType;
  List<dynamic> attachments;
  String name;
  String code;
  bool enabled;
  String additionalField;

  factory MainCategories.fromJson(Map<String, dynamic> json) => MainCategories(
    arabicName: json['arabicName'],
    adCost: json["adCost"],
    additionalField : json["additionalField"],
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
    "adCost" :adCost,
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
