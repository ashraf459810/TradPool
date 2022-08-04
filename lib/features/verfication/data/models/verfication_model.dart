// To parse this JSON data, do
//
//     final verificationResponse = verificationResponseFromJson(jsonString);

import 'dart:convert';

VerificationResponse verificationResponseFromJson(String str) => VerificationResponse.fromJson(json.decode(str));

String verificationResponseToJson(VerificationResponse data) => json.encode(data.toJson());

class VerificationResponse {
    VerificationResponse({
        this.version,
        this.creationDate,
        this.lastModificationDate,
        this.id,
        this.objectType,
        this.attachments,
        this.name,
        this.mobileNumber,
        this.normalizedMobileNumber,
        this.email,
        this.address,
        this.description,
        this.blocked,
        this.receiveNotifications,
        this.tk,
    });

    int version;
    DateTime creationDate;
    DateTime lastModificationDate;
    String id;
    String objectType;
    List<dynamic> attachments;
    String name;
    String mobileNumber;
    String normalizedMobileNumber;
    String email;
    dynamic address;
    dynamic description;
    bool blocked;
    bool receiveNotifications;
    String tk;

    factory VerificationResponse.fromJson(Map<String, dynamic> json) => VerificationResponse(
        version: json["version"],
        creationDate: DateTime.parse(json["creationDate"]),
        lastModificationDate: DateTime.parse(json["lastModificationDate"]),
        id: json["id"],
        objectType: json["objectType"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        normalizedMobileNumber: json["normalizedMobileNumber"],
        email: json["email"],
        address: json["address"],
        description: json["description"],
        blocked: json["blocked"],
        receiveNotifications: json["receiveNotifications"],
        tk: json["tk"],
    );

    Map<String, dynamic> toJson() => {
        "version": version,
        "creationDate": creationDate.toIso8601String(),
        "lastModificationDate": lastModificationDate.toIso8601String(),
        "id": id,
        "objectType": objectType,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "name": name,
        "mobileNumber": mobileNumber,
        "normalizedMobileNumber": normalizedMobileNumber,
        "email": email,
        "address": address,
        "description": description,
        "blocked": blocked,
        "receiveNotifications": receiveNotifications,
        "tk": tk,
    };
}
