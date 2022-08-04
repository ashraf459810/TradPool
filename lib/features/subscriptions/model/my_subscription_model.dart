// // To parse this JSON data, do
// //
// //     final mySubscriptionResponseModel = mySubscriptionResponseModelFromJson(jsonString);

// import 'dart:convert';

// MySubscriptionResponseModel mySubscriptionResponseModelFromJson(String str) => MySubscriptionResponseModel.fromJson(json.decode(str));

// String mySubscriptionResponseModelToJson(MySubscriptionResponseModel data) => json.encode(data.toJson());

// class MySubscriptionResponseModel {
//     MySubscriptionResponseModel({
//         this.content,
//         this.pageable,
//         this.totalPages,
//         this.last,
//         this.totalElements,
//         this.numberOfElements,
//         this.size,
//         this.number,
//         this.sort,
//         this.first,
//         this.empty,
//     });

//     List<Content> content;
//     Pageable pageable;
//     int totalPages;
//     bool last;
//     int totalElements;
//     int numberOfElements;
//     int size;
//     int number;
//     Sort sort;
//     bool first;
//     bool empty;

//     factory MySubscriptionResponseModel.fromJson(Map<String, dynamic> json) => MySubscriptionResponseModel(
      
//         content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
//         pageable: Pageable.fromJson(json["pageable"]),
//         totalPages: json["totalPages"],
//         last: json["last"],
//         totalElements: json["totalElements"],
//         numberOfElements: json["numberOfElements"],
//         size: json["size"],
//         number: json["number"],
//         sort: Sort.fromJson(json["sort"]),
//         first: json["first"],
//         empty: json["empty"],
//     );

//     Map<String, dynamic> toJson() => {
//         "content": List<dynamic>.from(content.map((x) => x.toJson())),
//         "pageable": pageable.toJson(),
//         "totalPages": totalPages,
//         "last": last,
//         "totalElements": totalElements,
//         "numberOfElements": numberOfElements,
//         "size": size,
//         "number": number,
//         "sort": sort.toJson(),
//         "first": first,
//         "empty": empty,
//     };
// }

// class Content {
//     Content({
//         this.subscriptionActivationId,
//         this.clientId,
//         this.fromDate,
//         this.toDate,
//         this.monthlyAdsCount,
//         this.monthlyCost,
//         this.type,
//         this.remainingAds,
//         this.status,
//         this.payments,
//         this.client,
//     });

//     String subscriptionActivationId;
//     String clientId;
//     int remainingAds;
//     DateTime fromDate;
//     DateTime toDate;
//     int monthlyAdsCount;
//     double monthlyCost;
//     dynamic type;
//     String status;
//     List<dynamic> payments;
//     Client client;

//     factory Content.fromJson(Map<String, dynamic> json) => Content(
//         subscriptionActivationId: json["subscriptionActivationId"],
//         clientId: json["clientId"],
//         fromDate: DateTime.parse(json["fromDate"]),
//         remainingAds:  json["remainingAds"],
//         toDate: DateTime.parse(json["toDate"]),
//         monthlyAdsCount: json["monthlyAdsCount"],
//         monthlyCost: json["monthlyCost"].toDouble(),
//         type: json["type"],
//         status: json["status"],
//         payments: List<dynamic>.from(json["payments"].map((x) => x)),
//         client: Client.fromJson(json["client"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "subscriptionActivationId": subscriptionActivationId,
//         "clientId": clientId,
//         "fromDate": fromDate.toIso8601String(),
//         "toDate": toDate.toIso8601String(),
//         "monthlyAdsCount": monthlyAdsCount,
//         "monthlyCost": monthlyCost,
//         "type": type,
//         "status": status,
//         "payments": List<dynamic>.from(payments.map((x) => x)),
//         "client": client.toJson(),
//     };
// }

// class Client {
//     Client({
//         this.version,
//         this.creationDate,
//         this.lastModificationDate,
//         this.id,
//         this.objectType,
//         this.attachments,
//         this.name,
//         this.mobileNumber,
//         this.normalizedMobileNumber,
//         this.email,
//         this.address,
//         this.description,
//         this.blocked,
//         this.receiveNotifications,
//         this.userType,
//         this.autoApproveAds,
//     });

//     int version;
//     DateTime creationDate;
//     DateTime lastModificationDate;
//     String id;
//     String objectType;
//     List<dynamic> attachments;
//     String name;
//     String mobileNumber;
//     String normalizedMobileNumber;
//     String email;
//     dynamic address;
//     dynamic description;
//     bool blocked;
//     bool receiveNotifications;
//     String userType;
//     bool autoApproveAds;

//     factory Client.fromJson(Map<String, dynamic> json) => Client(
//         version: json["version"],
//         creationDate: DateTime.parse(json["creationDate"]),
//         lastModificationDate: DateTime.parse(json["lastModificationDate"]),
//         id: json["id"],
//         objectType: json["objectType"],
//         attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
//         name: json["name"],
//         mobileNumber: json["mobileNumber"],
//         normalizedMobileNumber: json["normalizedMobileNumber"],
//         email: json["email"],
//         address: json["address"],
//         description: json["description"],
//         blocked: json["blocked"],
//         receiveNotifications: json["receiveNotifications"],
//         userType: json["userType"],
//         autoApproveAds: json["autoApproveAds"],
//     );

//     Map<String, dynamic> toJson() => {
//         "version": version,
//         "creationDate": creationDate.toIso8601String(),
//         "lastModificationDate": lastModificationDate.toIso8601String(),
//         "id": id,
//         "objectType": objectType,
//         "attachments": List<dynamic>.from(attachments.map((x) => x)),
//         "name": name,
//         "mobileNumber": mobileNumber,
//         "normalizedMobileNumber": normalizedMobileNumber,
//         "email": email,
//         "address": address,
//         "description": description,
//         "blocked": blocked,
//         "receiveNotifications": receiveNotifications,
//         "userType": userType,
//         "autoApproveAds": autoApproveAds,
//     };
// }

// class Pageable {
//     Pageable({
//         this.sort,
//         this.offset,
//         this.pageNumber,
//         this.pageSize,
//         this.paged,
//         this.unpaged,
//     });

//     Sort sort;
//     int offset;
//     int pageNumber;
//     int pageSize;
//     bool paged;
//     bool unpaged;

//     factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
//         sort: Sort.fromJson(json["sort"]),
//         offset: json["offset"],
//         pageNumber: json["pageNumber"],
//         pageSize: json["pageSize"],
//         paged: json["paged"],
//         unpaged: json["unpaged"],
//     );

//     Map<String, dynamic> toJson() => {
//         "sort": sort.toJson(),
//         "offset": offset,
//         "pageNumber": pageNumber,
//         "pageSize": pageSize,
//         "paged": paged,
//         "unpaged": unpaged,
//     };
// }

// class Sort {
//     Sort({
//         this.unsorted,
//         this.sorted,
//         this.empty,
//     });

//     bool unsorted;
//     bool sorted;
//     bool empty;

//     factory Sort.fromJson(Map<String, dynamic> json) => Sort(
//         unsorted: json["unsorted"],
//         sorted: json["sorted"],
//         empty: json["empty"],
//     );

//     Map<String, dynamic> toJson() => {
//         "unsorted": unsorted,
//         "sorted": sorted,
//         "empty": empty,
//     };
// }


// To parse this JSON data, do
//
//     final mySubscriptionResponseModel = mySubscriptionResponseModelFromJson(jsonString);

import 'dart:convert';

MySubscriptionResponseModel mySubscriptionResponseModelFromJson(String str) => MySubscriptionResponseModel.fromJson(json.decode(str));

String mySubscriptionResponseModelToJson(MySubscriptionResponseModel data) => json.encode(data.toJson());

class MySubscriptionResponseModel {
    MySubscriptionResponseModel({
        this.content,
        this.pageable,
        this.totalElements,
        this.totalPages,
        this.last,
        this.numberOfElements,
        this.size,
        this.number,
        this.sort,
        this.first,
        this.empty,
    });

    List<Content> content;
    Pageable pageable;
    int totalElements;
    int totalPages;
    bool last;
    int numberOfElements;
    int size;
    int number;
    Sort sort;
    bool first;
    bool empty;

    factory MySubscriptionResponseModel.fromJson(Map<String, dynamic> json) => MySubscriptionResponseModel(
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        last: json["last"],
        numberOfElements: json["numberOfElements"],
        size: json["size"],
        number: json["number"],
        sort: Sort.fromJson(json["sort"]),
        first: json["first"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "totalElements": totalElements,
        "totalPages": totalPages,
        "last": last,
        "numberOfElements": numberOfElements,
        "size": size,
        "number": number,
        "sort": sort.toJson(),
        "first": first,
        "empty": empty,
    };
}

class Content {
    Content({
        this.subscriptionActivationId,
        this.clientId,
        this.fromDate,
        this.toDate,
        this.monthlyAdsCount,
        this.monthlyCost,
        this.type,
        this.status,
        this.attachments,
        this.payments,
        this.client,
    });

    String subscriptionActivationId;
    String clientId;
    DateTime fromDate;
    DateTime toDate;
    int monthlyAdsCount;
    double monthlyCost;
    String type;
    String status;
    List<dynamic> attachments;
    List<Payment> payments;
    Client client;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        subscriptionActivationId: json["subscriptionActivationId"],
        clientId: json["clientId"],
        fromDate: DateTime.parse(json["fromDate"]),
        toDate: DateTime.parse(json["toDate"]),
        monthlyAdsCount: json["monthlyAdsCount"],
        monthlyCost: json["monthlyCost"].toDouble(),
        type: json["type"] ,
        status: json["status"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        payments: List<Payment>.from(json["payments"].map((x) => Payment.fromJson(x))),
        client: Client.fromJson(json["client"]),
    );

    Map<String, dynamic> toJson() => {
        "subscriptionActivationId": subscriptionActivationId,
        "clientId": clientId,
        "fromDate": fromDate.toIso8601String(),
        "toDate": toDate.toIso8601String(),
        "monthlyAdsCount": monthlyAdsCount,
        "monthlyCost": monthlyCost,
        "type": type ,
        "status": status,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
        "client": client.toJson(),
    };
}

class Client {
    Client({
        this.version,
        this.creationDate,
        this.lastModificationDate,
        this.id,
        this.objectType,
        this.attachments,
        this.name,
        this.mobileNumber,
        this.normalizedMobileNumber,
        this.email,
        this.address,
        this.description,
        this.blocked,
        this.receiveNotifications,
        this.userType,
        this.autoApproveAds,
    });

    int version;
    DateTime creationDate;
    DateTime lastModificationDate;
    String id;
    String objectType;
    List<dynamic> attachments;
    String name;
    String mobileNumber;
    String normalizedMobileNumber;
    String email;
    String address;
    String description;
    bool blocked;
    bool receiveNotifications;
    String userType;
    bool autoApproveAds;

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        version: json["version"],
        creationDate: DateTime.parse(json["creationDate"]),
        lastModificationDate: DateTime.parse(json["lastModificationDate"]),
        id: json["id"],
        objectType: json["objectType"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        normalizedMobileNumber: json["normalizedMobileNumber"],
        email: json["email"],
        address: json["address"],
        description: json["description"],
        blocked: json["blocked"],
        receiveNotifications: json["receiveNotifications"],
        userType: json["userType"],
        autoApproveAds: json["autoApproveAds"],
    );

    Map<String, dynamic> toJson() => {
        "version": version,
        "creationDate": creationDate.toIso8601String(),
        "lastModificationDate": lastModificationDate.toIso8601String(),
        "id": id,
        "objectType": objectType,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "name": name,
        "mobileNumber": mobileNumber,
        "normalizedMobileNumber": normalizedMobileNumber,
        "email": email,
        "address": address,
        "description": description ,
        "blocked": blocked,
        "receiveNotifications": receiveNotifications,
        "userType": userType,
        "autoApproveAds": autoApproveAds,
    };
}

class Payment {
    Payment({
        this.subscriptionPaymentId,
        this.subscriptionActivationId,
        this.fromDate,
        this.toDate,
        this.status,
        this.remainingAds,
    });

    String subscriptionPaymentId;
    String subscriptionActivationId;
    DateTime fromDate;
    DateTime toDate;
    String status;
    int remainingAds;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        subscriptionPaymentId: json["subscriptionPaymentId"],
        subscriptionActivationId: json["subscriptionActivationId"],
        fromDate: DateTime.parse(json["fromDate"]),
        toDate: DateTime.parse(json["toDate"]),
        status: json["status"],
        remainingAds: json["remainingAds"],
    );

    Map<String, dynamic> toJson() => {
        "subscriptionPaymentId": subscriptionPaymentId,
        "subscriptionActivationId": subscriptionActivationId,
        "fromDate": fromDate.toIso8601String(),
        "toDate": toDate.toIso8601String(),
        "status":status,
        "remainingAds": remainingAds,
    };
}



class Pageable {
    Pageable({
        this.sort,
        this.offset,
        this.pageNumber,
        this.pageSize,
        this.paged,
        this.unpaged,
    });

    Sort sort;
    int offset;
    int pageNumber;
    int pageSize;
    bool paged;
    bool unpaged;

    factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        offset: json["offset"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        paged: json["paged"],
        unpaged: json["unpaged"],
    );

    Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "offset": offset,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
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



