// To parse this JSON data, do
//
//     final buyAuctionModel = buyAuctionModelFromJson(jsonString);

import 'dart:convert';

List<BuyAuctionModel> buyAuctionModelFromJson(String str) => List<BuyAuctionModel>.from(json.decode(str).map((x) => BuyAuctionModel.fromJson(x)));

String buyAuctionModelToJson(List<BuyAuctionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BuyAuctionModel {
    BuyAuctionModel({
        this.attachments,
        this.id,
        this.lastPrice,
        this.location,
        this.mainCategory,
        this.name,
        this.sellType,
        this.subCategory,
        this.timeToEnd,
        this.viewers,
        this.tags,
        this.subscriptionType,


    });
String subscriptionType;
    List<Attachment> attachments;
    String id;
    int lastPrice;
    String location;
    Category mainCategory;
    String name;
    String sellType;
    Category subCategory;
    List<String> tags;
    String timeToEnd;
    int viewers;

    factory BuyAuctionModel.fromJson(Map<String, dynamic> json) => BuyAuctionModel(
      subscriptionType:  json['subscriptionType'],
            tags: List<String>.from(json["tags"].map((x) => x)),
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
        id: json["id"],
        lastPrice: json["lastPrice"],
        location: json["location"],
        mainCategory: Category.fromJson(json["mainCategory"]),
        name: json["name"],
        sellType: json["sellType"],
        subCategory: Category.fromJson(json["subCategory"]),
        timeToEnd: json["timeToEnd"],
        viewers: json["viewers"],
    );

    Map<String, dynamic> toJson() => {
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "id": id,
        "lastPrice": lastPrice,
        "location": location,
        "mainCategory": mainCategory.toJson(),
        "name": name,
        "sellType": sellType,
        "subCategory": subCategory.toJson(),
        "timeToEnd": timeToEnd,
        "viewers": viewers,
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

class Category {
    Category({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
