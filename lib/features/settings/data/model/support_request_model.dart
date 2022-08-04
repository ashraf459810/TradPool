// To parse this JSON data, do
//
//     final supportRequestDetailsModel = supportRequestDetailsModelFromJson(jsonString);

import 'dart:convert';

SupportRequestDetailsModel supportRequestDetailsModelFromJson(String str) => SupportRequestDetailsModel.fromJson(json.decode(str));

String supportRequestDetailsModelToJson(SupportRequestDetailsModel data) => json.encode(data.toJson());

class SupportRequestDetailsModel {
    SupportRequestDetailsModel({
        this.client,
        this.creationDate,
        this.doneDate,
        this.finalDecision,
        this.id,
        this.status,
        this.text,
        this.type,
    });

    Client client;
    DateTime creationDate;
    DateTime doneDate;
    String finalDecision;
    String id;
    String status;
    String text;
    Type type;

    factory SupportRequestDetailsModel.fromJson(Map<String, dynamic> json) => SupportRequestDetailsModel(
        client: Client.fromJson(json["client"]),
        creationDate: DateTime.parse(json["creationDate"]),
        doneDate: json['doneDate'] !=null? DateTime.parse(json["doneDate"]):null,
        finalDecision: json["finalDecision"],
        id: json["id"],
        status: json["status"],
        text: json["text"],
        type: Type.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "client": client.toJson(),
        "creationDate": creationDate.toIso8601String(),
        "doneDate": doneDate.toIso8601String(),
        "finalDecision": finalDecision,
        "id": id,
        "status": status,
        "text": text,
        "type": type.toJson(),
    };
}

class Client {
    Client({
        this.email,
        this.name,
        this.normalizedMobileNumber,
    });

    String email;
    String name;
    String normalizedMobileNumber;

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        email: json["email"],
        name: json["name"],
        normalizedMobileNumber: json["normalizedMobileNumber"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "normalizedMobileNumber": normalizedMobileNumber,
    };
}

class Type {
    Type({
        this.code,
        this.id,
        this.name,
    });

    String code;
    String id;
    String name;

    factory Type.fromJson(Map<String, dynamic> json) => Type(
        code: json["code"],
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "id": id,
        "name": name,
    };
}
