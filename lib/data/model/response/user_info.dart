
import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

// String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.image,
    this.type,
    this.gender,
    this.occupation,
    this.twoFactor,
    this.fcmToken,
    this.balance,
    this.uniqueId,
    this.qrCode,
  });

  String fName;
  String lName;
  String phone;
  String email;
  String image;
  int type;
  String gender;
  String occupation;
  bool twoFactor;
  String fcmToken;
  double balance;
  String uniqueId;
  String qrCode;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    fName: json["f_name"],
    lName: json["l_name"],
    phone: json["phone"],
    email: json["email"],
    image: json["image"],
    type: json["type"],
    gender: json["gender"],
    occupation: json["occupation"],
    twoFactor: json["two_factor"]==1?true:false,
    fcmToken: json["fcm_token"],
    balance: json["balance"].toDouble() ?? 0.0,
    uniqueId: json["unique_id"],
    qrCode: json["qr_code"],
  );
}
