// To parse this JSON data, do
//
//     final calculateResponseModel = calculateResponseModelFromJson(jsonString);

import 'dart:convert';

CalculateResponseModel calculateResponseModelFromJson(String str) => CalculateResponseModel.fromJson(json.decode(str));

String calculateResponseModelToJson(CalculateResponseModel data) => json.encode(data.toJson());

class CalculateResponseModel {
    CalculateResponseModel({
        this.selectedObjectAd,
        this.uploadMoreThanFivePhotos,
        this.addressRequired,
        this.total,
        this.reservationPrice,
        this.adCost,
        this.idRequired,
        this.endTime,
        this.highlightedAd,
        this.remainingAds,
        this.subscriptionType
    });

    int selectedObjectAd;
    int uploadMoreThanFivePhotos;
    String 
subscriptionType;
int remainingAds
;
    bool addressRequired;
    int total;
    int reservationPrice;
    int adCost;
    bool idRequired;
    int endTime;
    int highlightedAd;

    factory CalculateResponseModel.fromJson(Map<String, dynamic> json) => CalculateResponseModel(
      remainingAds: json["remainingAds"],
      subscriptionType: json["subscriptionType"],
        selectedObjectAd: json["Selected object AD"],
        uploadMoreThanFivePhotos: json["Upload more than five photos"],
        addressRequired: json["addressRequired"],
        total: json["Total"],
        reservationPrice: json["Reservation price"],
        adCost: json["AD cost"],
        idRequired: json["idRequired"],
        endTime: json["End time"],
        highlightedAd: json["Highlighted AD"],
    );

    Map<String, dynamic> toJson() => {
        "Selected object AD": selectedObjectAd,
        "Upload more than five photos": uploadMoreThanFivePhotos,
        "addressRequired": addressRequired,
        "Total": total,
        "Reservation price": reservationPrice,
        "AD cost": adCost,
        "idRequired": idRequired,
        "End time": endTime,
        "Highlighted AD": highlightedAd,
    };
}
