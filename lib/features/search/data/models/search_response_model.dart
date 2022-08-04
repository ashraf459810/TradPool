// To parse this JSON data, do
//
//     final searchResponseModel = searchResponseModelFromJson(jsonString);

import 'dart:convert';

SearchResponseModel searchResponseModelFromJson(String str) => SearchResponseModel.fromJson(json.decode(str));

String searchResponseModelToJson(SearchResponseModel data) => json.encode(data.toJson());

class SearchResponseModel {
    SearchResponseModel({
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

    List<SearchResult> content;
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

    factory SearchResponseModel.fromJson(Map<String, dynamic> json) => SearchResponseModel(
        content: List<SearchResult>.from(json["content"].map((x) => SearchResult.fromJson(x))),
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

class SearchResult {
    SearchResult({
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
String subscriptionType;
    List<Attachment> attachments;
    List<String> tags;
    Brand brand;
    String deliverType;
    String id;
    int lastPrice;
    String location;
    Brand mainCategory;
    String name;
    String productCondition;
    String sellType;
    String shippingPayer;
    Brand subCategory;
    String timeToEnd;
    int viewers;

    factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
      subscriptionType: json['subscriptionType'],
            tags: List<String>.from(json["tags"].map((x) => x)),
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
        brand: json['brand'] !=null ? Brand.fromJson(json["brand"]):null,
        deliverType: json["deliverType"],
        id: json["id"],
        lastPrice: json["lastPrice"],
        location: json["location"],
        mainCategory:  Brand.fromJson(json["mainCategory"]),
        name: json["name"],
        productCondition: json["productCondition"],
        sellType: json["sellType"],
        shippingPayer: json["shippingPayer"],
        subCategory: Brand.fromJson(json["subCategory"]),
        timeToEnd: json["timeToEnd"],
        viewers: json["viewers"],
    );

    Map<String, dynamic> toJson() => {
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "brand": brand.toJson(),
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
