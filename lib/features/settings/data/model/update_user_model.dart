// To parse this JSON data, do
//
//     final updateUserBody = updateUserBodyFromJson(jsonString);

import 'dart:convert';

import '../../../auction_details/data/model/auction_details.dart';

UpdateUserBody updateUserBodyFromJson(String str) => UpdateUserBody.fromJson(json.decode(str));

String updateUserBodyToJson(UpdateUserBody data) => json.encode(data.toJson());

class UpdateUserBody {
    UpdateUserBody({
        this.id,
        this.name,
        this.email,
        this.mobileNumber,
        this.description,
        this.receiveNotifications,
        this.attachments,
    });

    String id;
    String name;
    String email;
    String mobileNumber;
    String description;
    bool receiveNotifications;
    List<Attachment> attachments;

    factory UpdateUserBody.fromJson(Map<String, dynamic> json) => UpdateUserBody(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        description: json["description"],
        receiveNotifications: json["receiveNotifications"],
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobileNumber": mobileNumber,
        "description": description,
        "receiveNotifications": receiveNotifications,
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
    };
}


