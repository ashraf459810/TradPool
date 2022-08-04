// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.notifications,
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

  List<NotificationsList> notifications;
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

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notifications: List<NotificationsList>.from(
            json["content"].map((x) => NotificationsList.fromJson(x))),
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
        "content": List<dynamic>.from(notifications.map((x) => x.toJson())),
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

class NotificationsList {
  NotificationsList({
    this.version,
    this.creationDate,
    this.lastModificationDate,
    this.id,
    this.objectType,
    this.attachments,
    this.receiverId,
    this.receiverType,
    this.notificationType,
    this.title,
    this.body,
    this.targetId,
    this.targetType,
    this.context,
    this.type,
    this.seen,
  });

  int version;
  DateTime creationDate;
  DateTime lastModificationDate;
  String id;
  String objectType;
  List<dynamic> attachments;
  String receiverId;
  String receiverType;
  String notificationType;
  String title;
  String body;
  String targetId;
  String targetType;
  Context context;
  String type;
  bool seen;

  factory NotificationsList.fromJson(Map<String, dynamic> json) =>
      NotificationsList(
        version: json["version"],
        creationDate: DateTime.parse(json["creationDate"]),
        lastModificationDate: DateTime.parse(json["lastModificationDate"]),
        id: json["id"],
        objectType: json["objectType"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        receiverId: json["receiverId"],
        receiverType: json["receiverType"],
        notificationType: json["notificationType"],
        title: json["title"],
        body: json["body"],
        targetId: json["targetId"],
        targetType: json["targetType"],
        context: Context.fromJson(json["context"]),
        type: json["type"],
        seen: json["seen"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "creationDate": creationDate.toIso8601String(),
        "lastModificationDate": lastModificationDate.toIso8601String(),
        "id": id,
        "objectType": objectType,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "receiverId": receiverId,
        "receiverType": receiverType,
        "notificationType": notificationType,
        "title": title,
        "body": body,
        "targetId": targetId,
        "targetType": targetType,
        "context": context.toJson(),
        "type": type,
        "seen": seen,
      };
}

class Context {
  Context({
    this.redirectTo,
    this.id,
    this.type,
  });

  String redirectTo;
  String id;
  String type;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        redirectTo: json["redirectTo"],
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "redirectTo": redirectTo,
        "id": id,
        "type": type,
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
