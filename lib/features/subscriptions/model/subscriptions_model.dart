// To parse this JSON data, do
//
//     final subscriptionsResponseModel = subscriptionsResponseModelFromJson(jsonString);

import 'dart:convert';

SubscriptionsResponseModel subscriptionsResponseModelFromJson(String str) => SubscriptionsResponseModel.fromJson(json.decode(str));

String subscriptionsResponseModelToJson(SubscriptionsResponseModel data) => json.encode(data.toJson());

class SubscriptionsResponseModel {
    SubscriptionsResponseModel({
        this.content,
        this.pageable,
        this.last,
        this.totalPages,
        this.totalElements,
        this.first,
        this.sort,
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
    bool first;
    Sort sort;
    int numberOfElements;
    int size;
    int number;
    bool empty;

    factory SubscriptionsResponseModel.fromJson(Map<String, dynamic> json) => SubscriptionsResponseModel(
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        first: json["first"],
        sort: Sort.fromJson(json["sort"]),
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
        "first": first,
        "sort": sort.toJson(),
        "numberOfElements": numberOfElements,
        "size": size,
        "number": number,
        "empty": empty,
    };
}

class Content {
    Content({
        this.subscriptionId,
        this.name,
        this.type,
        this.periodInMonths,
        this.monthlyCost,
        this.monthlyAdsCount,
        this.isActive,
    });

    String subscriptionId;
    String name;
    String type;
    int periodInMonths;
    double monthlyCost;
    int monthlyAdsCount;
    bool isActive;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        subscriptionId: json["subscriptionId"],
        name: json["name"],
        type: json["type"],
        periodInMonths: json["periodInMonths"],
        monthlyCost: json["monthlyCost"].toDouble(),
        monthlyAdsCount: json["monthlyAdsCount"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "subscriptionId": subscriptionId,
        "name": name,
        "type": type,
        "periodInMonths": periodInMonths,
        "monthlyCost": monthlyCost,
        "monthlyAdsCount": monthlyAdsCount,
        "isActive": isActive,
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
