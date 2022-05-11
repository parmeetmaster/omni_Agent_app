import 'dart:convert';

import 'package:flutter/cupertino.dart';
String contactModelToJson(ContactModel data) => json.encode(data.toJson());
class ContactModel {
  final String phoneNumber;
  String name;
  String avatarImage;

  ContactModel({@required this.phoneNumber, this.name, this.avatarImage});
  factory ContactModel.fromJson(Map<String, dynamic> json)=> ContactModel(
      phoneNumber: json["phoneNumber"],
      name: json["name"],
      avatarImage: json["avatarImage"] ?? null,
  );
  Map<String, dynamic> toJson()=> {
    "phoneNumber": phoneNumber,
    "name": name,
    "avatarImage": avatarImage,
  };

}