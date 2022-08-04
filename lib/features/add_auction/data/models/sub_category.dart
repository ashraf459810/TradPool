// To parse this JSON data, do
//
//     final subCategories = subCategoriesFromJson(jsonString);

import 'dart:convert';

List<SubCategories> subCategoriesFromJson(String str) =>
    List<SubCategories>.from(
        json.decode(str).map((x) => SubCategories.fromJson(x)));

String subCategoriesToJson(List<SubCategories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategories {
  SubCategories({
    this.id,
    this.version,
    this.creationDate,
    this.lastModificationDate,
    this.uuid,
    this.objectType,
    this.attachments,
    this.name,
    this.code,
    this.arabicName,
    this.enabled,
  });

  String id;
  int version;
  DateTime creationDate;
  DateTime lastModificationDate;
  String uuid;
  String objectType;
  List<dynamic> attachments;
  String name;
  String code;
  bool enabled;

String arabicName;
  factory SubCategories.fromJson(Map<String, dynamic> json) => SubCategories(
    arabicName: json["arabicName"],
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
