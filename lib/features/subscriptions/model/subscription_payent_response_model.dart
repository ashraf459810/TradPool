// To parse this JSON data, do
//
//     final subscriptionPaymentResponseModel = subscriptionPaymentResponseModelFromJson(jsonString);

import 'dart:convert';

SubscriptionPaymentResponseModel subscriptionPaymentResponseModelFromJson(String str) => SubscriptionPaymentResponseModel.fromJson(json.decode(str));

String subscriptionPaymentResponseModelToJson(SubscriptionPaymentResponseModel data) => json.encode(data.toJson());

class SubscriptionPaymentResponseModel {
    SubscriptionPaymentResponseModel({
        this.subscriptionPaymentId,
        this.subscriptionActivationId,
        this.fromDate,
        this.toDate,
        this.status,
    });

    String subscriptionPaymentId;
    dynamic subscriptionActivationId;
    DateTime fromDate;
    DateTime toDate;
    String status;

    factory SubscriptionPaymentResponseModel.fromJson(Map<String, dynamic> json) => SubscriptionPaymentResponseModel(
        subscriptionPaymentId: json["subscriptionPaymentId"],
        subscriptionActivationId: json["subscriptionActivationId"],
        fromDate: DateTime.parse(json["fromDate"]),
        toDate: DateTime.parse(json["toDate"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "subscriptionPaymentId": subscriptionPaymentId,
        "subscriptionActivationId": subscriptionActivationId,
        "fromDate": fromDate.toIso8601String(),
        "toDate": toDate.toIso8601String(),
        "status": status,
    };
}
