// To parse this JSON data, do
//
//     final supportTypeModel = supportTypeModelFromJson(jsonString);

import 'dart:convert';

List<SupportTypeModel> supportTypeModelFromJson(String str) => List<SupportTypeModel>.from(json.decode(str).map((x) => SupportTypeModel.fromJson(x)));

String supportTypeModelToJson(List<SupportTypeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupportTypeModel {
    SupportTypeModel({
        this.version,
        this.creationDate,
        this.lastModificationDate,
        this.id,
        this.objectType,
        this.attachments,
        this.name,
        this.code,
        this.enabled,
    });

    int version;
    DateTime creationDate;
    DateTime lastModificationDate;
    String id;
    String objectType;
    List<dynamic> attachments;
    String name;
    String code;
    bool enabled;

    factory SupportTypeModel.fromJson(Map<String, dynamic> json) => SupportTypeModel(
        version: json["version"],
        creationDate: DateTime.parse(json["creationDate"]),
        lastModificationDate: DateTime.parse(json["lastModificationDate"]),
        id: json["id"],
        objectType: json["objectType"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        name: json["name"],
        code: json["code"],
        enabled: json["enabled"],
    );

    Map<String, dynamic> toJson() => {
        "version": version,
        "creationDate": creationDate.toIso8601String(),
        "lastModificationDate": lastModificationDate.toIso8601String(),
        "id": id,
        "objectType": objectType,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "name": name,
        "code": code,
        "enabled": enabled,
    };
}
