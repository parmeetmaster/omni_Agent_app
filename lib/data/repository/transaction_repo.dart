import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/util/app_constants.dart';

class TransactionRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  TransactionRepo({@required this.apiClient, @required this.sharedPreferences});


  // Future<Response>  getPurposeListApi() async {
  //   return await apiClient.getData(AppConstants.AGENT_PURPOSE_URL );
  // }

  Future<Response>  cashInApi({@required String phoneNumber, @required double amount, @required String pin }) async {
    return await apiClient.postData(AppConstants.AGENT_CASH_IN, {'phone': phoneNumber, 'amount': amount, 'pin': pin});
  }

  Future<Response>  requestMoneyApi({ @required double amount}) async {
    return await apiClient.postData(AppConstants.AGENT_REQUEST_MONEY,  {'amount' : amount});
  }
  Future<Response>  cashOutApi({@required double amount, @required String pin}) async {
    return await apiClient.postData(AppConstants.AGENT_CASH_OUT, {'amount' : amount, 'pin' : pin});
  }

  Future<Response>  checkCustomerNumber({@required String phoneNumber}) async {
    return await apiClient.postData(AppConstants.CHECK_CUSTOMER_URI, {'phone' : phoneNumber});
  }
  Future<Response>  checkAgentNumber({@required String phoneNumber}) async {
    return await apiClient.postData(AppConstants.CHECK_AGENT_URI, {'phone' : phoneNumber});
  }


  List<ContactModel>  getSuggestList()  {
    List<String> suggests  = [];
    if(sharedPreferences.containsKey(AppConstants.SEND_MONEY_SUGGEST_LIST)){
       suggests =  sharedPreferences.getStringList(AppConstants.SEND_MONEY_SUGGEST_LIST);

    }
    if(suggests != null){
      List<ContactModel> contactList = [];
      suggests.forEach((contact) => contactList.add(ContactModel.fromJson(jsonDecode(contact))));
      print('contact list : ==> $contactList');
      return  contactList;

    }
    return null;

  }

  void addToSuggestList(List<ContactModel> contactModelList,{@required String type}) async {
    List<String> suggests  = [];
    contactModelList.forEach((contactModel) => suggests.add(jsonEncode(contactModel)));
    if(type == 'send_money') {
      sharedPreferences.setStringList(AppConstants.SEND_MONEY_SUGGEST_LIST, suggests);
    }
    else if(type == 'request_money'){
      sharedPreferences.setStringList(AppConstants.REQUEST_MONEY_SUGGEST_LIST, suggests);
    }
    else if(type == "cash_out"){
    sharedPreferences.setStringList(AppConstants.RECENT_AGENT_LIST, suggests);
    }
  }




}