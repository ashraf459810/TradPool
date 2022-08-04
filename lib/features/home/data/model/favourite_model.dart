// To parse this JSON data, do
//
//     final favouritesModel = favouritesModelFromJson(jsonString);

import 'dart:convert';

FavouritesModel favouritesModelFromJson(String str) => FavouritesModel.fromJson(json.decode(str));

String favouritesModelToJson(FavouritesModel data) => json.encode(data.toJson());

class FavouritesModel {
    FavouritesModel({
        this.content,
        this.pageable,
        this.last,
        this.totalPages,
        this.totalElements,
        this.size,
        this.number,
      
        this.numberOfElements,
        this.first,
        this.empty,
    });

    List<Content> content;
    Pageable pageable;
    bool last;
    int totalPages;
    int totalElements;
    int size;
    int number;

    int numberOfElements;
    bool first;
    bool empty;

    factory FavouritesModel.fromJson(Map<String, dynamic> json) => FavouritesModel(
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        size: json["size"],
        number: json["number"],
        
        numberOfElements: json["numberOfElements"],
        first: json["first"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "last": last,
        "totalPages": totalPages,
        "totalElements": totalElements,
        "size": size,
        "number": number,
       
        "numberOfElements": numberOfElements,
        "first": first,
        "empty": empty,
    };
}

class Content {
    Content({
        this.attachments,
        this.brand,
        this.deliverType,
        this.id,
        this.lastPrice,
        this.location,
        this.mainCategory,
        this.name,
        this.productCondition,
        this.sellType,
        this.shippingPayer,
        this.subCategory,
        this.timeToEnd,
        this.viewers,
        this.tags,
        this.subscriptionType
    });

    List<Attachment> attachments;
    dynamic brand;
    String deliverType;
    String id;
    int lastPrice;
    String location;
    Category mainCategory;
    String name;
    String productCondition;
    String sellType;
    String shippingPayer;
    Category subCategory;
    String timeToEnd;
    int viewers;
    List<String>tags;
  String  subscriptionType;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
      subscriptionType:  json['subscriptionType'],
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
        brand: json["brand"],
        deliverType: json["deliverType"],
        id: json["id"],
        lastPrice: json["lastPrice"],
              tags: List<String>.from(json["tags"].map((x) => x)),
        location: json["location"],
        mainCategory: Category.fromJson(json["mainCategory"]),
        name: json["name"],
        productCondition: json["productCondition"],
        sellType: json["sellType"],
        shippingPayer: json["shippingPayer"],
        subCategory: Category.fromJson(json["subCategory"]),
        timeToEnd: json["timeToEnd"],
        viewers: json["viewers"],
    );

    Map<String, dynamic> toJson() => {
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "brand": brand,
        "deliverType": deliverType,
        "id": id,
        "lastPrice": lastPrice,
        "location": location,
        "mainCategory": mainCategory.toJson(),
        "name": name,
        "productCondition": productCondition,
        "sellType": sellType,
        "shippingPayer": shippingPayer,
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

class Pageable {
    Pageable({
      
        this.pageNumber,
        this.pageSize,
        this.offset,
        this.unpaged,
        this.paged,
    });


    int pageNumber;
    int pageSize;
    int offset;
    bool unpaged;
    bool paged;

    factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(

        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        offset: json["offset"],
        unpaged: json["unpaged"],
        paged: json["paged"],
    );

    Map<String, dynamic> toJson() => {

        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "offset": offset,
        "unpaged": unpaged,
        "paged": paged,
    };
}


