// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

class ConfigModel {
  ConfigModel({
    this.companyName,
    this.companyLogo,
    this.companyAddress,
    this.companyPhone,
    this.companyEmail,
    this.baseUrls,
    this.currencySymbol,
    this.currencyPosition,
    this.cashoutChargePercent,
    this.addmoneyChargePercent,
    this.sendmoneyChargeFlat,
    this.agentCommissionPercent,
    this.adminCommission,
    this.twoFactor,
    this.country,
    this.termsAndConditions,
    this.privacyPolicy,
    this.aboutUs,
    this.theme,
  });

  String companyName;
  String companyLogo;
  String companyAddress;
  String companyPhone;
  String companyEmail;
  BaseUrls baseUrls;
  String currencySymbol;
  String currencyPosition;
  int cashoutChargePercent;
  int addmoneyChargePercent;
  int sendmoneyChargeFlat;
  int agentCommissionPercent;
  int adminCommission;
  bool twoFactor;
  String country;
  String termsAndConditions;
  String privacyPolicy;
  String aboutUs;
  String theme;

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    companyName: json["company_name"],
    companyLogo: json["company_logo"],
    companyAddress: json["company_address"],
    companyPhone: json["company_phone"],
    companyEmail: json["company_email"],
    baseUrls: BaseUrls.fromJson(json["base_urls"]),
    currencySymbol: json["currency_symbol"] ?? '\$',
    currencyPosition: json["currency_position"] ?? 'left',
    cashoutChargePercent: json["cashout_charge_percent"],
    addmoneyChargePercent: json["addmoney_charge_percent"],
    sendmoneyChargeFlat: json["sendmoney_charge_flat"],
    agentCommissionPercent: json["agent_commission_percent"],
    adminCommission: json["admin_commission"],
    twoFactor: json["two_factor"]==1?true: false,
    country: json["country"] ?? 'BD',
    termsAndConditions: json["terms_and_conditions"],
    privacyPolicy: json["privacy_policy"],
    aboutUs: json["about_us"],
    theme: json["user_app_theme"],
  );
}

class BaseUrls {
  BaseUrls({
    this.customerImageUrl,
    this.agentImageUrl,
    this.linkedWebsiteImageUrl,
    this.purposeImageUrl,
    this.notificationImageUrl,
    this.companyImageUrl,
    this.bannerImageUrl,
  });

  String customerImageUrl;
  String agentImageUrl;
  String linkedWebsiteImageUrl;
  String purposeImageUrl;
  String notificationImageUrl;
  String companyImageUrl;
  String bannerImageUrl;

  factory BaseUrls.fromJson(Map<String, dynamic> json) => BaseUrls(
    customerImageUrl: json["customer_image_url"],
    agentImageUrl: json["agent_image_url"],
    linkedWebsiteImageUrl: json["linked_website_image_url"],
    purposeImageUrl: json["purpose_image_url"],
    notificationImageUrl: json["notification_image_url"],
    companyImageUrl: json["company_image_url"],
    bannerImageUrl: json["banner_image_url"],
  );
}
