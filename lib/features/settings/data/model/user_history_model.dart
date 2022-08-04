// To parse this JSON data, do
//
//     final userHistoryModel = userHistoryModelFromJson(jsonString);

import 'dart:convert';

UserHistoryModel userHistoryModelFromJson(String str) => UserHistoryModel.fromJson(json.decode(str));

String userHistoryModelToJson(UserHistoryModel data) => json.encode(data.toJson());

class UserHistoryModel {
    UserHistoryModel({
        this.content,
        this.pageable,
        this.last,
        this.totalPages,
        this.totalElements,
        this.sort,
        this.numberOfElements,
        this.first,
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
    int numberOfElements;
    bool first;
    int size;
    int number;
    bool empty;

    factory UserHistoryModel.fromJson(Map<String, dynamic> json) => UserHistoryModel(
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        sort: Sort.fromJson(json["sort"]),
        numberOfElements: json["numberOfElements"],
        first: json["first"],
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
        "numberOfElements": numberOfElements,
        "first": first,
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
    MainCategory brand;
    String buyerFeedback;
    int buyerRate;
    String deliverType;
    dynamic directSellPrice;
    String id;
    dynamic lastPrice;
    String location;
    MainCategory mainCategory;
    String name;
    String productCondition;
    String sellType;
    String sellerFeedback;
    int sellerRate;
    String shippingPayer;
    String status;
    MainCategory subCategory;
    String timeToEnd;
    int viewers;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
        brand: json["brand"] == null ? null : MainCategory.fromJson(json["brand"]),
        buyerFeedback: json["buyerFeedback"] ,
        buyerRate: json["buyerRate"] ,
        deliverType: json["deliverType"],
        directSellPrice: json["directSellPrice"],
        id: json["id"],
        lastPrice: json["lastPrice"],
        location: json["location"],
        mainCategory: MainCategory.fromJson(json["mainCategory"]),
        name: json["name"],
        productCondition: json["productCondition"],
        sellType: json["sellType"],
        sellerFeedback: json["sellerFeedback"],
        sellerRate: json["sellerRate"] ,
        shippingPayer: json["shippingPayer"],
        status: json["status"],
        subCategory: MainCategory.fromJson(json["subCategory"]),
        timeToEnd: json["timeToEnd"],
        viewers: json["viewers"],
    );

    Map<String, dynamic> toJson() => {
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        // ignore: prefer_null_aware_operators
        "brand": brand == null ? null : brand.toJson(),
        "buyerFeedback": buyerFeedback,
        "buyerRate": buyerRate,
        "deliverType": deliverType,
        "directSellPrice": directSellPrice,
        "id": id,
        "lastPrice": lastPrice ,
        "location": location,
        "mainCategory": mainCategory.toJson(),
        "name": name,
        "productCondition": productCondition,
        "sellType": sellType,
        "sellerFeedback": sellerFeedback ,
        "sellerRate": sellerRate ,
        "shippingPayer": shippingPayer,
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

class MainCategory {
    MainCategory({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
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
        this.unpaged,
        this.paged,
    });

    Sort sort;
    int pageNumber;
    int pageSize;
    int offset;
    bool unpaged;
    bool paged;

    factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        offset: json["offset"],
        unpaged: json["unpaged"],
        paged: json["paged"],
    );

    Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "offset": offset,
        "unpaged": unpaged,
        "paged": paged,
    };
}

class Sort {
    Sort({
        this.sorted,
        this.unsorted,
        this.empty,
    });

    bool sorted;
    bool unsorted;
    bool empty;

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        sorted: json["sorted"],
        unsorted: json["unsorted"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "sorted": sorted,
        "unsorted": unsorted,
        "empty": empty,
    };
}
