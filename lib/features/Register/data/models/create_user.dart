// To parse this JSON data, do
//
//     final createUser = createUserFromJson(jsonString);

import 'dart:convert';

import 'package:tradpool/features/register/domain/entities/create_user_entity.dart';

CreateUserModel createUserFromJson(String str) =>
    CreateUserModel.fromJson(json.decode(str));

String createUserToJson(CreateUserModel data) => json.encode(data.toJson());

class CreateUserModel extends CreateUserEntity {
  final String namemodel;
  final String emailmodel;
  final String mobileNumbermodel;
  final String addressmodel;
  final String descriptionmodel;
  final bool receiveNotificationsmodel;
  const CreateUserModel({
    this.namemodel,
    this.emailmodel,
    this.mobileNumbermodel,
    this.addressmodel,
    this.descriptionmodel,
    this.receiveNotificationsmodel,
  });

  factory CreateUserModel.fromJson(Map<String, dynamic> json) =>
      CreateUserModel(
        namemodel: json["name"],
        emailmodel: json["email"],
        mobileNumbermodel: json["mobileNumber"],
        addressmodel: json["address"],
        descriptionmodel: json["description"],
        receiveNotificationsmodel: json["receiveNotifications"],
      );

  Map<String, dynamic> toJson() => {
        "name": namemodel,
        "email": emailmodel,
        "mobileNumber": mobileNumbermodel,
        "address": addressmodel,
        "description": descriptionmodel,
        "receiveNotifications": receiveNotificationsmodel,
      };
}
