// To parse this JSON data, do
//
//     final requestSubscriptionBody = requestSubscriptionBodyFromJson(jsonString);

import 'dart:convert';

RequestSubscriptionBody requestSubscriptionBodyFromJson(String str) => RequestSubscriptionBody.fromJson(json.decode(str));

String requestSubscriptionBodyToJson(RequestSubscriptionBody data) => json.encode(data.toJson());

class RequestSubscriptionBody {
    RequestSubscriptionBody({
        this.subscriptionId,
        this.fromDate,
        this.attachments,
    });

    String subscriptionId;
    String fromDate;
    List<Attachment> attachments;

    factory RequestSubscriptionBody.fromJson(Map<String, dynamic> json) => RequestSubscriptionBody(
        subscriptionId: json["subscriptionId"],
        fromDate:json["fromDate"],
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "subscriptionId": subscriptionId,
        "fromDate": fromDate,
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
    };
}

class Attachment {
    Attachment({
        this.file,
        this.id,
        this.name,
        this.progress,
        this.tag,
    });

    String file;
    String id;
    String name;
    int progress;
    String tag;

    factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        file: json["file"],
        id: json["id"],
        name: json["name"],
        progress: json["progress"],
        tag: json["tag"],
    );

    Map<String, dynamic> toJson() => {
        "file": file,
        "id": id,
        "name": name,
        "progress": progress,
        "tag": tag,
    };
}


