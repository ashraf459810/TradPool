// To parse this JSON data, do
//
//     final messageRequestBody = messageRequestBodyFromJson(jsonString);

import 'dart:convert';



MessageRequestBody messageRequestBodyFromJson(String str) => MessageRequestBody.fromJson(json.decode(str));

String messageRequestBodyToJson(MessageRequestBody data) => json.encode(data.toJson());

class MessageRequestBody {
    MessageRequestBody({
        this.message,
        this.sender,
        this.sellRequest,
        this.attachments,
    });

    String message;
    SellRequest sender;
    SellRequest sellRequest;
    List<SellRequest> attachments;

    factory MessageRequestBody.fromJson(Map<String, dynamic> json) => MessageRequestBody(
        message: json["message"],
        sender: SellRequest.fromJson(json["sender"]),
        sellRequest: SellRequest.fromJson(json["sellRequest"]),
        attachments: List<SellRequest>.from(json["attachments"].map((x) => SellRequest.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "message": message,
        "sender": sender.toJson(),
        "sellRequest": sellRequest.toJson(),
        "attachments": attachments!=null? List<dynamic>.from(attachments.map((x) => x.toJson())):null,
    };
}

class SellRequest {
    SellRequest({
        this.id,
    });

    String id;

    factory SellRequest.fromJson(Map<String, dynamic> json) => SellRequest(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
