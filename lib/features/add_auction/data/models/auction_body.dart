// To parse this JSON data, do
//
//     final auctionBody = auctionBodyFromJson(jsonString);

import 'dart:convert';

AuctionBody auctionBodyFromJson(String str) =>
    AuctionBody.fromJson(json.decode(str));

String auctionBodyToJson(AuctionBody data) => json.encode(data.toJson());

class AuctionBody {
  AuctionBody(
      {this.seller,
      this.mainCategory,
      this.subCategory,
      this.brand,
      this.condition,
      this.startPrice,
      this.minPrice,
      this.directSellEnabled,
      this.directSellPrice,
      this.length,
      this.width,
      this.height,
      this.description,
      this.days,
      this.hourOfEnd,
      this.minuteOfEnd,
      this.deliverType,
      this.shippingPayer,
      this.fixedSellEnabled,
      this.auctionSellEnabled,
      this.shareMobile,
      this.shareEmail,
      this.attachments,
      this.additionalInfo,
      this.highlighted,
      this.selectedObjec,
      this.tags,
      this.name});
  String name;
  Obj seller;
  String additionalInfo;
  bool highlighted;
     bool selectedObjec ;
  List<String>tags;
  Obj mainCategory;
  Obj subCategory;
  String brand;
  String condition;
  int startPrice;
  int minPrice;
  bool directSellEnabled;
  int directSellPrice;
  double length;
  double width;
  int height;
  String description;
  int days;
  int hourOfEnd;
  int minuteOfEnd;
  String deliverType;
  String shippingPayer;
  bool fixedSellEnabled;
  bool auctionSellEnabled;
  bool shareMobile;
  bool shareEmail;
  List<Obj> attachments;

  factory AuctionBody.fromJson(Map<String, dynamic> json) => AuctionBody(
        highlighted:  json["highlighted"],
        selectedObjec:  json["selectedObjec"],
        name: json['name'],
        seller: Obj.fromJson(json["seller"]),
        mainCategory: Obj.fromJson(json["mainCategory"]),
        subCategory: Obj.fromJson(json["subCategory"]),
        brand: json["strBrand"],
        condition: json["condition"],
        startPrice: json["startPrice"],
        minPrice: json["minPrice"],
        directSellEnabled: json["directSellEnabled"],
        directSellPrice: json["directSellPrice"],
        length: json["length"].toDouble(),
        width: json["width"].toDouble(),
        height: json["height"],
        description: json["description"],
        days: json["days"],
        hourOfEnd: json["hourOfEnd"],
        minuteOfEnd: json["minuteOfEnd"],
        deliverType: json["deliverType"],
        shippingPayer: json["shippingPayer"],
        fixedSellEnabled: json["fixedSellEnabled"],
        auctionSellEnabled: json["auctionSellEnabled"],
        shareMobile: json["shareMobile"],
        shareEmail: json["shareEmail"],
        attachments:
            List<Obj>.from(json["attachments"].map((x) => Obj.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "highlighted" :highlighted,
    "selectedObjec" :selectedObjec,
    "additionalInfo" : additionalInfo,
        "seller": seller.toJson(),
        "mainCategory": mainCategory.toJson(),
        "subCategory": subCategory.toJson(),
        // ignore: prefer_null_aware_operators
        "strBrand": brand ,
        "condition": condition,
        "startPrice": startPrice,
        "minPrice": minPrice,
        "directSellEnabled": directSellEnabled,
        "directSellPrice": directSellPrice,
        "length": length,
        "width": width,
        "height": height,
        "description": description,
        "days": days,
        "hourOfEnd": hourOfEnd,
        "minuteOfEnd": minuteOfEnd,
        "deliverType": deliverType,
        "shippingPayer": shippingPayer,
        "fixedSellEnabled": fixedSellEnabled,
        "auctionSellEnabled": auctionSellEnabled,
        "shareMobile": shareMobile,
        "shareEmail": shareEmail,
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "name": name,
          "tags": List<dynamic>.from(tags.map((x) => x))
      };
}

class Obj {
  Obj({
    this.id,
  });

  String id;

  factory Obj.fromJson(Map<String, dynamic> json) => Obj(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
