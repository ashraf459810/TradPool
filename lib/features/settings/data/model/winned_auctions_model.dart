// To parse this JSON data, do
//
//     final winnedAuctionsModel = winnedAuctionsModelFromJson(jsonString);

import 'dart:convert';

WinnedAuctionsModel winnedAuctionsModelFromJson(String str) => WinnedAuctionsModel.fromJson(json.decode(str));

String winnedAuctionsModelToJson(WinnedAuctionsModel data) => json.encode(data.toJson());

class WinnedAuctionsModel {
    WinnedAuctionsModel({
        this.content,
        this.pageable,
        this.last,
        this.totalPages,
        this.totalElements,
        this.sort,
        this.first,
        this.numberOfElements,
        this.size,
        this.number,
        this.empty,
    });

    List<Content> content;
    Pageable pageable;
    bool last;
    int totalPages;
    int totalElements;
    Sort sort;
    bool first;
    int numberOfElements;
    int size;
    int number;
    bool empty;

    factory WinnedAuctionsModel.fromJson(Map<String, dynamic> json) => WinnedAuctionsModel(
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        sort: Sort.fromJson(json["sort"]),
        first: json["first"],
        numberOfElements: json["numberOfElements"],
        size: json["size"],
        number: json["number"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "last": last,
        "totalPages": totalPages,
        "totalElements": totalElements,
        "sort": sort.toJson(),
        "first": first,
        "numberOfElements": numberOfElements,
        "size": size,
        "number": number,
        "empty": empty,
    };
}

class Content {
    Content({
        this.attachments,
        this.brand,
        this.buyerFeedback,
        this.buyerRate,
        this.deliverType,
        this.directSellPrice,
        this.id,
        this.lastPrice,
        this.location,
        this.mainCategory,
        this.name,
        this.productCondition,
        this.sellType,
        this.sellerFeedback,
        this.sellerRate,
        this.shippingPayer,
        this.status,
        this.subCategory,
        this.timeToEnd,
        this.viewers,
    });

    List<Attachment> attachments;
    dynamic brand;
    dynamic buyerFeedback;
    dynamic buyerRate;
    String deliverType;
    int directSellPrice;
    String id;
    int lastPrice;
    String location;
    Category mainCategory;
    String name;
    String productCondition;
    String sellType;
    dynamic sellerFeedback;
    dynamic sellerRate;
    String shippingPayer;
    String status;
    Category subCategory;
    String timeToEnd;
    int viewers;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
        brand: json["brand"],
        buyerFeedback: json["buyerFeedback"],
        buyerRate: json["buyerRate"],
        deliverType: json["deliverType"],
        directSellPrice: json["directSellPrice"],
        id: json["id"],
        lastPrice: json["lastPrice"],
        location: json["location"],
        mainCategory: Category.fromJson(json["mainCategory"]),
        name: json["name"],
        productCondition: json["productCondition"],
        sellerFeedback: json["sellerFeedback"],
        sellerRate: json["sellerRate"],
        shippingPayer: json["shippingPayer"],
        subCategory: Category.fromJson(json["subCategory"]),
        timeToEnd: json["timeToEnd"],
        viewers: json["viewers"],
    );

    Map<String, dynamic> toJson() => {
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "brand": brand,
        "buyerFeedback": buyerFeedback,
        "buyerRate": buyerRate,
        "deliverType": deliverType,
        "directSellPrice": directSellPrice,
        "id": id,
        "lastPrice": lastPrice,
        "location": location,
        "mainCategory": mainCategory.toJson(),
        "name": name,
        "productCondition": productCondition ,
        "sellType": sellType,
        "sellerFeedback": sellerFeedback,
        "sellerRate": sellerRate,
        "shippingPayer": shippingPayer ,
        "status": status,
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
        this.sort,
        this.pageNumber,
        this.pageSize,
        this.offset,
        this.paged,
        this.unpaged,
    });

    Sort sort;
    int pageNumber;
    int pageSize;
    int offset;
    bool paged;
    bool unpaged;

    factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        offset: json["offset"],
        paged: json["paged"],
        unpaged: json["unpaged"],
    );

    Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "offset": offset,
        "paged": paged,
        "unpaged": unpaged,
    };
}

class Sort {
    Sort({
        this.unsorted,
        this.sorted,
        this.empty,
    });

    bool unsorted;
    bool sorted;
    bool empty;

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        unsorted: json["unsorted"],
        sorted: json["sorted"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "unsorted": unsorted,
        "sorted": sorted,
        "empty": empty,
    };
}
  