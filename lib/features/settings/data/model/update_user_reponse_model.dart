// To parse this JSON data, do
//
//     final updateUserResponseModel = updateUserResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateUserResponseModel updateUserResponseModelFromJson(String str) => UpdateUserResponseModel.fromJson(json.decode(str));

String updateUserResponseModelToJson(UpdateUserResponseModel data) => json.encode(data.toJson());

class UpdateUserResponseModel {
    UpdateUserResponseModel({
        this.address,
        this.attachments,
        this.autoApproveAds,
        this.blocked,
        this.description,
        this.email,
        this.mobileNumber,
        this.name,
        this.preferences,
        this.receiveNotifications,
        this.userType,
    });

    String address;
    List<Attachment> attachments;
    bool autoApproveAds;
    bool blocked;
    String description;
    String email;
    String mobileNumber;
    String name;
    List<Preference> preferences;
    bool receiveNotifications;
    String userType;

    factory UpdateUserResponseModel.fromJson(Map<String, dynamic> json) => UpdateUserResponseModel(
        address: json["address"],
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
        autoApproveAds: json["autoApproveAds"],
        blocked: json["blocked"],
        description: json["description"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        name: json["name"],
        preferences: List<Preference>.from(json["preferences"].map((x) => Preference.fromJson(x))),
        receiveNotifications: json["receiveNotifications"],
        userType: json["userType"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "autoApproveAds": autoApproveAds,
        "blocked": blocked,
        "description": description,
        "email": email,
        "mobileNumber": mobileNumber,
        "name": name,
        "preferences": List<dynamic>.from(preferences.map((x) => x.toJson())),
        "receiveNotifications": receiveNotifications,
        "userType": userType,
    };
}

class Attachment {
    Attachment({
        this.publicUrl,
    });

    String publicUrl;

    factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        publicUrl: json["publicURL"],
    );

    Map<String, dynamic> toJson() => {
        "publicURL": publicUrl,
    };
}

class Preference {
    Preference({
        this.mainCategory,
        this.data,
    });

    MainCategory mainCategory;
    List<Datum> data;

    factory Preference.fromJson(Map<String, dynamic> json) => Preference(
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
