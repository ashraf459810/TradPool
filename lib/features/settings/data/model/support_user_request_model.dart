// To parse this JSON data, do
//
//     final supportRequestModel = supportRequestModelFromJson(jsonString);

import 'dart:convert';

SupportRequestModel supportRequestModelFromJson(String str) => SupportRequestModel.fromJson(json.decode(str));

String supportRequestModelToJson(SupportRequestModel data) => json.encode(data.toJson());

class SupportRequestModel {
    SupportRequestModel({
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

    factory SupportRequestModel.fromJson(Map<String, dynamic> json) => SupportRequestModel(
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
        this.client,
        this.creationDate,
        this.doneDate,
        this.finalDecision,
        this.id,
        this.status,
        this.text,
        this.type,
    });

    Client client;
    DateTime creationDate;
    dynamic doneDate;
    dynamic finalDecision;
    String id;
    String status;
    String text;
    Type type;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        client: Client.fromJson(json["client"]),
        creationDate: DateTime.parse(json["creationDate"]),
        doneDate: json["doneDate"],
        finalDecision: json["finalDecision"],
        id: json["id"],
        status: json["status"],
        text: json["text"],
        type: Type.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "client": client.toJson(),
        "creationDate": creationDate.toIso8601String(),
        "doneDate": doneDate,
        "finalDecision": finalDecision,
        "id": id,
        "status": status,
        "text": text,
        "type": type.toJson(),
    };
}

class Client {
    Client({
        this.email,
        this.name,
        this.normalizedMobileNumber,
    });

    String email;
    String name;
    String normalizedMobileNumber;

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        email: json["email"],
        name: json["name"],
        normalizedMobileNumber: json["normalizedMobileNumber"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "normalizedMobileNumber": normalizedMobileNumber,
    };
}

class Type {
    Type({
        this.code,
        this.id,
        this.name,
    });

    String code;
    String id;
    String name;

    factory Type.fromJson(Map<String, dynamic> json) => Type(
        code: json["code"],
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
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
