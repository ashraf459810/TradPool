// To parse this JSON data, do
//
//     final userAuctionsModel = userAuctionsModelFromJson(jsonString);

import 'dart:convert';

UserAuctionsModel userAuctionsModelFromJson(String str) => UserAuctionsModel.fromJson(json.decode(str));

String userAuctionsModelToJson(UserAuctionsModel data) => json.encode(data.toJson());

class UserAuctionsModel {
    UserAuctionsModel({
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

    List<UserAuctions> content;
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

    factory UserAuctionsModel.fromJson(Map<String, dynamic> json) => UserAuctionsModel(
        content: List<UserAuctions>.from(json["content"].map((x) => UserAuctions.fromJson(x))),
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

class UserAuctions {
    UserAuctions({
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
        this.tags,
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
    dynamic lastPrice;
    String location;
    Category mainCategory;
    String name;
    dynamic productCondition;
    String sellType;
    dynamic sellerFeedback;
    dynamic sellerRate;
    dynamic shippingPayer;
    String status;
    Category subCategory;
    List<String> tags;
    String timeToEnd;
    int viewers;

    factory UserAuctions.fromJson(Map<String, dynamic> json) => UserAuctions(
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
        sellType: json["sellType"],
        sellerFeedback: json["sellerFeedback"],
        sellerRate: json["sellerRate"],
        shippingPayer: json["shippingPayer"],
        status: json["status"],
        subCategory: Category.fromJson(json["subCategory"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
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
        "productCondition": productCondition,
        "sellType": sellType,
        "sellerFeedback": sellerFeedback,
        "sellerRate": sellerRate,
        "shippingPayer": shippingPayer,
        "status": status,
        "subCategory": subCategory.toJson(),
        "tags": List<dynamic>.from(tags.map((x) => x)),
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
