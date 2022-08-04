// To parse this JSON data, do
//
//     final addBidResponse = addBidResponseFromJson(jsonString);

import 'dart:convert';

AddBidResponse addBidResponseFromJson(String str) => AddBidResponse.fromJson(json.decode(str));

String addBidResponseToJson(AddBidResponse data) => json.encode(data.toJson());

class AddBidResponse {
    AddBidResponse({
    
        this.auctionSellEnabled,
        this.autoBidButtonEnabled,
        this.bidRequests,
        this.brand,
        this.creationDate,
        this.deliverType,
        this.description,
        this.directSellEnabled,
        this.directSellPrice,
        this.fixedSellEnabled,
        this.height,
        this.id,
        this.lastPrice,
     
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
    });

  
    bool auctionSellEnabled;
    bool autoBidButtonEnabled;
    List<BidRequest> bidRequests;
    dynamic brand;
    DateTime creationDate;
    String deliverType;
    String description;
    bool directSellEnabled;
    dynamic directSellPrice;
    bool fixedSellEnabled;
    dynamic height;
    String id;
    int lastPrice;

    String location;
    Category mainCategory;
    bool manualBidButtonEnabled;
    String name;
    dynamic productCondition;
    String sellType;
    Seller seller;
    dynamic shippingPayer;
    int startPrice;
    String status;
    Category subCategory;
    String timeToEnd;
    bool updateAutoBidButtonEnabled;
    int viewers;
    dynamic width;

    factory AddBidResponse.fromJson(Map<String, dynamic> json) => AddBidResponse(
     
        auctionSellEnabled: json["auctionSellEnabled"],
        autoBidButtonEnabled: json["autoBidButtonEnabled"],
        bidRequests: List<BidRequest>.from(json["bidRequests"].map((x) => BidRequest.fromJson(x))),
        brand: json["brand"],
        creationDate: DateTime.parse(json["creationDate"]),
        deliverType: json["deliverType"],
        description: json["description"],
        directSellEnabled: json["directSellEnabled"],
        directSellPrice: json["directSellPrice"],
        fixedSellEnabled: json["fixedSellEnabled"],
        height: json["height"],
        id: json["id"],
        lastPrice: json["lastPrice"],
     
        location: json["location"],
        mainCategory: Category.fromJson(json["mainCategory"]),
        manualBidButtonEnabled: json["manualBidButtonEnabled"],
        name: json["name"],
        productCondition: json["productCondition"],
        sellType: json["sellType"],
        seller: Seller.fromJson(json["seller"]),
        shippingPayer: json["shippingPayer"],
        startPrice: json["startPrice"],
        status: json["status"],
        subCategory: Category.fromJson(json["subCategory"]),
        timeToEnd: json["timeToEnd"],
        updateAutoBidButtonEnabled: json["updateAutoBidButtonEnabled"],
        viewers: json["viewers"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
  
        "auctionSellEnabled": auctionSellEnabled,
        "autoBidButtonEnabled": autoBidButtonEnabled,
        "bidRequests": List<dynamic>.from(bidRequests.map((x) => x.toJson())),
        "brand": brand,
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

class BidRequest {
    BidRequest({
        this.bidder,
        this.creationDate,
        this.price,
    });

    Seller bidder;
    DateTime creationDate;
    int price;

    factory BidRequest.fromJson(Map<String, dynamic> json) => BidRequest(
        bidder: Seller.fromJson(json["bidder"]),
        creationDate: DateTime.parse(json["creationDate"]),
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "bidder": bidder.toJson(),
        "creationDate": creationDate.toIso8601String(),
        "price": price,
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


