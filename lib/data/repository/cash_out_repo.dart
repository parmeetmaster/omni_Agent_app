import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/util/app_constants.dart';

class CashOutRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CashOutRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response>  cashOutApi({@required String phoneNumber, @required double amount, @required String pin}) async {
    Map<String, Object> body = {'phone' : phoneNumber, 'amount' : amount, 'pin' : pin};
    return await apiClient.postData(AppConstants.AGENT_CASH_OUT, body);
  }
  Future<Response>  pinVerifyApi({@required String pin}) async {
    Map<String, Object> body = {'pin': pin};
    return await apiClient.postData(AppConstants.AGENT_PIN_VERIFY, body);
  }
  List<ContactModel> getRecentAgentList()  {
    List<String> recent  = [];
    if(sharedPreferences.containsKey(AppConstants.RECENT_AGENT_LIST)){
      recent =  sharedPreferences.getStringList(AppConstants.RECENT_AGENT_LIST);
    }
    if(recent != null){
      List<ContactModel> contactList = [];
      recent.forEach((contact) => contactList.add(ContactModel.fromJson(jsonDecode(contact))));
      return  contactList;

    }
    return null;

  }

  void addToRecentAgentList(List<ContactModel> contactModelList) async {
    List<String> recent  = [];
    contactModelList.forEach((contactModel) => recent.add(jsonEncode(contactModel)));
    sharedPreferences.setStringList(AppConstants.RECENT_AGENT_LIST, recent);
  }
}