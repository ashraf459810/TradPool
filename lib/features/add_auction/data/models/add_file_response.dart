// To parse this JSON data, do
//
//     final addFileResponse = addFileResponseFromJson(jsonString);

import 'dart:convert';

List<AddFileResponse> addFileResponseFromJson(String str) =>
    List<AddFileResponse>.from(
        json.decode(str).map((x) => AddFileResponse.fromJson(x)));

String addFileResponseToJson(List<AddFileResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddFileResponse {
  AddFileResponse({
    this.id,
    this.version,
    this.creationDate,
    this.lastModificationDate,
    this.uuid,
    this.objectType,
    this.attachments,
    this.tag,
    this.extension,
    this.path,
    this.publicUrl,
    this.ownerId,
    this.ownerType,
    this.deleted,
    this.linked,
  });

  String id;
  int version;
  DateTime creationDate;
  DateTime lastModificationDate;
  String uuid;
  String objectType;
  List<dynamic> attachments;
  String tag;
  String extension;
  String path;
  String publicUrl;
  String ownerId;
  String ownerType;
  bool deleted;
  bool linked;

  factory AddFileResponse.fromJson(Map<String, dynamic> json) =>
      AddFileResponse(
        id: json["id"],
        version: json["version"],
        creationDate: DateTime.parse(json["creationDate"]),
        lastModificationDate: DateTime.parse(json["lastModificationDate"]),
        uuid: json["uuid"],
        objectType: json["objectType"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        tag: json["tag"],
        extension: json["extension"],
        path: json["path"],
        publicUrl: json["publicURL"],
        ownerId: json["ownerId"],
        ownerType: json["ownerType"],
        deleted: json["deleted"],
        linked: json["linked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "creationDate": creationDate.toIso8601String(),
        "lastModificationDate": lastModificationDate.toIso8601String(),
        "uuid": uuid,
        "objectType": objectType,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "tag": tag,
        "extension": extension,
        "path": path,
        "publicURL": publicUrl,
        "ownerId": ownerId,
        "ownerType": ownerType,
        "deleted": deleted,
        "linked": linked,
      };
}
