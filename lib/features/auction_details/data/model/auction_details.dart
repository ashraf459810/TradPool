// To parse this JSON data, do
//
//     final auctionDetailsModel = auctionDetailsModelFromJson(jsonString);

import 'dart:convert';

AuctionDetailsModel auctionDetailsModelFromJson(String str) => AuctionDetailsModel.fromJson(json.decode(str));

String auctionDetailsModelToJson(AuctionDetailsModel data) => json.encode(data.toJson());

class AuctionDetailsModel {
    AuctionDetailsModel({
      this.messages,
      this.sendMessageButtonLabel,
      this.sendMessageButtonEnabled,
      this.markAsDeliveredButtonEnabled,
      this.cancelButtonEnabled,
      this.buyerFeedback,
      this.sellerFeedback,
      this.buyerRate,
      this.sellerRate,
        this.attachments,
        this.auctionSellEnabled,
        this.autoBidButtonEnabled,
        this.bidRequests,
        this.brand,
        this.creationDate,
     this.   buyerFeedbackEnabled,
     this.sellerFeedbackEnabled,
        this.deliverType,
        this.description,
        this.directSellEnabled,
        this.directSellPrice,
        this.fixedSellEnabled,
        this.height,
        this.id,
        this.lastPrice,
      this.withdrawButtonEnabled,
      this.directBuyButtonEnabled,
        this.location,
        this.mainCategory,
        this.manualBidButtonEnabled,
        this.name,
        this.productCondition,
        this.sellType,
        this.seller,
        this.shippingPayer,
        this.startPrice,
        this.status,
        this.subCategory,
        this.timeToEnd,
        this.updateAutoBidButtonEnabled,
        this.viewers,
        this.width,
        this.autoBidMaxPrice,
        this.lastUserBid,
        this.sellerEmail,
        this.tags,
        this.sellerMobile
        
      
        
        
        
    });
    List<Message> messages;
    String sendMessageButtonLabel;
    bool sendMessageButtonEnabled;
    bool cancelButtonEnabled;
    bool markAsDeliveredButtonEnabled;
    bool sellerFeedbackEnabled;
    bool buyerFeedbackEnabled;
dynamic buyerRate;
dynamic sellerRate;
dynamic sellerEmail;
dynamic sellerMobile;
String buyerFeedback;
String sellerFeedback;
    List<Attachment> attachments;
    bool auctionSellEnabled;
    int lastUserBid;
    bool autoBidButtonEnabled;
    List<BidRequest> bidRequests;
    Brand brand;
    DateTime creationDate;
    String deliverType;
    String description;
    bool directSellEnabled;
    dynamic directSellPrice;
    bool fixedSellEnabled;
    dynamic height;
    String id;
    dynamic lastPrice;
    int autoBidMaxPrice;
     List<String>tags;
    bool withdrawButtonEnabled;
    bool directBuyButtonEnabled;
    String location;
    Brand mainCategory;
    bool manualBidButtonEnabled;
    String name;
    String productCondition;
    String sellType;
    Seller seller;
    dynamic shippingPayer;
    int startPrice;
    String status;
    Brand subCategory;
    String timeToEnd;
    bool updateAutoBidButtonEnabled;
    int viewers;
    dynamic width;

    factory AuctionDetailsModel.fromJson(Map<String, dynamic> json) => AuctionDetailsModel(
   messages: json["messages"] !=null ? List<Message>.from(json["messages"].map((x) => Message.fromJson(x))):null,
            tags: List<String>.from(json["tags"].map((x) => x)),
            sendMessageButtonLabel: json["sendMessageButtonLabel"],
            sendMessageButtonEnabled: json["sendMessageButtonEnabled"],
            markAsDeliveredButtonEnabled:  json['markAsDeliveredButtonEnabled'],
      sellerFeedbackEnabled: json['sellerFeedbackEnabled'],
      cancelButtonEnabled:   json["cancelButtonEnabled"],
      buyerFeedbackEnabled: json['buyerFeedbackEnabled'],
      sellerEmail: json['sellerEmail'],
      sellerMobile: json['sellerMobile'],
      buyerFeedback: json['buyerFeedback'],
      sellerFeedback: json['sellerFeedback'],
      buyerRate: json['buyerRate'],
      sellerRate: json['sellerRate'],
      lastUserBid : json['lastUserBid'],
      withdrawButtonEnabled : json['withdrawButtonEnabled'],
directBuyButtonEnabled : json['directBuyButtonEnabled'],
      autoBidMaxPrice :  json['autoBidMaxPrice'],
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
        auctionSellEnabled:  json["auctionSellEnabled"],
        autoBidButtonEnabled: json["autoBidButtonEnabled"],
        bidRequests: List<BidRequest>.from(json["bidRequests"].map((x) => BidRequest.fromJson(x))),
        brand: json['brand'] ==null? null: Brand.fromJson(json["brand"]) ,
        creationDate: DateTime.parse(json["creationDate"]),
        deliverType: json["deliverType"],
        description: json["description"],
        directSellEnabled: json["directSellEnabled"],
        directSellPrice: json["directSellPrice"],
        fixedSellEnabled: json["fixedSellEnabled"],
        height: json["height"],
        id: json["id"],
        lastPrice: json["lastPrice"] ,
   
        location: json["location"],
        mainCategory: Brand.fromJson(json["mainCategory"]),
        manualBidButtonEnabled: json["manualBidButtonEnabled"],
        name: json["name"],
        productCondition: json["productCondition"],
        sellType: json["sellType"],
        seller: Seller.fromJson(json["seller"]),
        shippingPayer: json["shippingPayer"],
        startPrice: json["startPrice"],
        status: json["status"],
        subCategory: Brand.fromJson(json["subCategory"]),
        timeToEnd: json["timeToEnd"],
        updateAutoBidButtonEnabled: json["updateAutoBidButtonEnabled"],
        viewers: json["viewers"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "auctionSellEnabled": auctionSellEnabled,
        "autoBidButtonEnabled": autoBidButtonEnabled,
        "bidRequests": List<dynamic>.from(bidRequests.map((x) => x.toJson())),
        // ignore: prefer_null_aware_operators
        "brand": brand!=null? brand.toJson():null,
        "creationDate": creationDate.toIso8601String(),
        "deliverType": deliverType,
        "description": description,
        "directSellEnabled": directSellEnabled,
        "directSellPrice": directSellPrice,
        "fixedSellEnabled": fixedSellEnabled,
        "height": height,
        "id": id,
        "lastPrice": lastPrice,
      
        "location": location,
        "mainCategory": mainCategory.toJson(),
        "manualBidButtonEnabled": manualBidButtonEnabled,
        "name": name,
        "productCondition": productCondition,
        "sellType": sellType,
        "seller": seller.toJson(),
        "shippingPayer": shippingPayer,
        "startPrice": startPrice,
        "status": status,
        "subCategory": subCategory.toJson(),
        "timeToEnd": timeToEnd,
        "updateAutoBidButtonEnabled": updateAutoBidButtonEnabled,
        "viewers": viewers,
        "width": width,
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

class BidRequest {
    BidRequest({
        this.bidder,
        this.price,
        this.creationDate,
    });

    Seller bidder;
    int price;
    DateTime creationDate;

    factory BidRequest.fromJson(Map<String, dynamic> json) => BidRequest(
        bidder: Seller.fromJson(json["bidder"]),
        price: json["price"],
        creationDate: DateTime.parse(json["creationDate"]),
    );

    Map<String, dynamic> toJson() => {
        "bidder": bidder.toJson(),
        "price": price,
        "creationDate": creationDate.toIso8601String(),
    };
}

class Seller {
    Seller({
        this.name,
    });

    String name;

    factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Brand {
    Brand({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

List<Message> messagesFromJson(String str) => List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));
class Message {
    Message({
        this.attachments,
        this.sender,
        this.senderType,
        this.message,
    });

    List<Attachment> attachments;
    Seller sender;
    String senderType;
    String message;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
         attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
        sender: Seller.fromJson(json["sender"]),
        senderType: json["senderType"],
        message: json["message"],
    );


 
}