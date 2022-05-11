import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/bootom_slider_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/model/az_model.dart';
import 'package:six_cash/data/model/purpose_models.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/data/repository/auth_repo.dart';
import 'package:six_cash/data/repository/contact_responce.dart';
import 'package:six_cash/data/repository/transaction_repo.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';
import 'package:six_cash/view/screens/transaction_money/widget/transaction_money_confirmation.dart';

class TransactionMoneyController extends GetxController implements GetxService {
  final ContactsResponse contactsResponce;
  final TransactionRepo transactionRepo;
  final AuthRepo authRepo;

  TransactionMoneyController({@required this.contactsResponce, @required this.transactionRepo, @required this.authRepo});
  BottomSliderController bottomSliderController = Get.find<BottomSliderController>();
  SplashController splashController = Get.find<SplashController>();
  ProfileController profileController = Get.find<ProfileController>();
  List<Contact> contactList = [];
  List<AzItem> filterdContacts = [];
  List<AzItem> azItemList = [];
  List<ContactModel> _sendMoneySuggestList = [];
  List<ContactModel> _requestMoneySuggestList = [];
  List<ContactModel> _cashOutSuggestList = [];
  List<String> inputAmountList =  AppConstants.inputAmountList;
  int _selectAmount;



  int get selectAmount => _selectAmount;

  void selectAmountSet(int value) {
    _selectAmount = value;
    update(['inputAmountListController']);
  }

  List<Purpose> _purposeList = [];
  Purpose _selectedPurpose;
  int _selectItem = 0;
  double _cashOutCharge = 0;

  bool _isLoading = false;
  bool purposeLoading = true;
  bool _isOtpFieldLoading = false;
  bool _isSuggestLoading = false;
  bool _isFutureSave = false;

  bool _isNextBottomSheet = false;
  bool _includeCharge = false;
  PermissionStatus permissionStatus;
  String _searchControllerValue = '';
  double _inputAmountControllerValue;

  List<Purpose> get purposeList => _purposeList;
  Purpose get selectedPurpose => _selectedPurpose;
  int get selectedItem => _selectItem;
  String get searchControllerValue => _searchControllerValue;
  double get inputAmountControllerValue => _inputAmountControllerValue;

  bool get isLoading => _isLoading;
  bool get  isOtpFieldLoading => _isOtpFieldLoading;
  bool get isSuggestLoading => _isSuggestLoading;

  bool get isNextBottomSheet => _isNextBottomSheet;
  bool get includeCharge => _includeCharge;
  double get cashOutCharge => _cashOutCharge;
  List<ContactModel> get sendMoneySuggestList => _sendMoneySuggestList;
  List<ContactModel> get requestMoneySuggestList => _requestMoneySuggestList;
  List<ContactModel> get cashOutSuggestList => _cashOutSuggestList;
  bool get isFutureSave => _isFutureSave;
  bool _isPinCompleted = false;
  bool get isPinCompleted => _isPinCompleted;
  String _pin;
  String get pin => _pin;
  bool _contactIsLoading;
  bool get contactIsLoading => _contactIsLoading;
  bool _isButtonClick = false;
  bool get isButtonClick => _isButtonClick;


  cupertinoSwitchOnChange(bool value) {
    _isFutureSave = value;
    update();
  }

  void setIsPinCompleted({@required bool isCompleted, bool isNotify}){
    _isPinCompleted =  isCompleted;
    if(isNotify) {
      update();
    }
  }
  changePinComleted(String value){
    if (value.length==4) {
      _isPinCompleted = true;
      _pin = value;
    }else{
      _isPinCompleted = false;
    }
    update();
  }


  // Future<Response> getPurposeList()async{
  //   _isLoading = true;
  //   Response response = await transactionRepo.getPurposeListApi();
  //   _purposeList = [];
  //   if(response.body != null && response.statusCode==200){
  //     var data =  response.body.map((a)=> Purpose.fromJson(a)).toList();
  //     for (var purpose in data) {
  //       _purposeList.add( Purpose(title: purpose.title,logo: purpose.logo, color: purpose.color));
  //     }
  //     _selectedPurpose = _purposeList[0];
  //     _isLoading = false;
  //   }else{
  //     _isLoading =  false;
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  //   return response;
  // }







  Future<Response> cashIn({@required ContactModel contactModel, @required double amount, String pinCode})async{
    _isLoading = true;
    _isNextBottomSheet = false;
    update();
   Response response = await transactionRepo.cashInApi(phoneNumber: contactModel.phoneNumber, amount: amount, pin: pinCode);
   if(response.statusCode == 200){
     _isLoading = false;
     _isNextBottomSheet = true;

   }else{
     _isLoading = false;
     ApiChecker.checkApi(response);
   }
   update();
   return response;
  }

  // Future<Response> requestMoney({@required ContactModel contactModel, @required double amount})async{
  //   _isLoading = true;
  //   _isNextBottomSheet = false;
  //   update();
  //   Response response = await transactionRepo.requestMoneyApi(phoneNumber: contactModel.phoneNumber, amount: amount);
  //   if(response.statusCode == 200){
  //     _isLoading = false;
  //     _isNextBottomSheet = true;
  //
  //     _requestMoneySuggestList.removeWhere((element) => element.phoneNumber == contactModel.phoneNumber);
  //     _requestMoneySuggestList.add(contactModel) ;
  //     transactionRepo.addToSuggestList(_requestMoneySuggestList,type: 'request_money');
  //     update();
  //   }else{
  //     _isLoading = false;
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  //   return response;
  // }
  Future<void> requestMoney({ @required double amount})async{
    _isLoading = true;
    update(['inout_screen_button_id']);
    Response response = await transactionRepo.requestMoneyApi(amount: amount);
    if(response.statusCode == 200){
      Get.back();
      showCustomSnackBar('request_send_successful'.tr, isError: false);
    }else{
      showCustomSnackBar(response.statusText, isError: true);
    }
    _isLoading = false;
    update(['inout_screen_button_id']);
  }
  Future<Response> cashOutMoney({@required double amount, String pinCode})async{
    _isLoading = true;
    _isNextBottomSheet = false;
    update();
    Response response = await transactionRepo.cashOutApi(amount: amount, pin: pinCode);
    if(response.statusCode == 200){
      _isLoading = false;
      _isNextBottomSheet = true;

      // if(_isFutureSave == true){
      //   _cashOutSuggestList.removeWhere((element) => element.phoneNumber == contactModel.phoneNumber);
      //   _cashOutSuggestList.add(contactModel) ;
      //   transactionRepo.addToSuggestList(_cashOutSuggestList,type: 'cash_out');
      // }

      // update();
    }else{
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }
  Future<Response> checkCustomerNumber({@required String phoneNumber})async{
    _isButtonClick = true;
    _isLoading = true;
    update(['inout_screen_button_id']);
    Response response = await transactionRepo.checkCustomerNumber(phoneNumber: phoneNumber);
    if(response.statusCode == 200){
      _isButtonClick = false;
    }else{
      _isButtonClick = false;
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> checkAgentNumber({@required String phoneNumber})async{
    _isButtonClick = true;
    update();
    Response response = await transactionRepo.checkAgentNumber(phoneNumber: phoneNumber);
    if(response.statusCode == 200){
      _isButtonClick = false;
    }else{
      _isButtonClick = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }


  void includeChargeStateChange(bool state){
    _includeCharge = state;
    update();
  }




  itemSelect({int index}){
    _selectItem = index;
    _selectedPurpose = purposeList[index];

    update();
  }

  ContactModel _contact;
  ContactModel get contact => _contact;
  void setContactModel(ContactModel contactModel){
    _contact = contactModel;
  }
 
  void  contactOnTap(int index, String transactionType){

    String phoneNumber = filterdContacts[index].contact.phones.first.number.trim();
    print(phoneNumber);
    if(phoneNumber.contains('-')){
      phoneNumber = phoneNumber.replaceAll('-', '');
    }
    if(!phoneNumber.contains(Get.find<AuthController>().getCustomerCountryCode())){
      phoneNumber = Get.find<AuthController>().getCustomerCountryCode()+phoneNumber.substring(1).trim();
    }
    if(phoneNumber.contains(' ')){
      phoneNumber = phoneNumber.replaceAll(' ', '');
    }

    print(phoneNumber);


      if(transactionType == "cash_out"){
        Get.find<TransactionMoneyController>().checkAgentNumber(phoneNumber: phoneNumber).then((value) {
          if(value.isOk){

            Get.to(()=> TransactionMoneyBalanceInput(transactionType: transactionType));
          }
        });
      }else{
        Get.find<TransactionMoneyController>().checkCustomerNumber(phoneNumber: phoneNumber).then((value) {
          if(value.isOk){
            Get.to(()=> TransactionMoneyBalanceInput(transactionType: transactionType));
          }
        });
      }

    }

  void suggestOnTap(int index, String transactionType){
    if(transactionType == 'send_money'){
      setContactModel(ContactModel(
          phoneNumber: _sendMoneySuggestList[index].phoneNumber,
          avatarImage: _sendMoneySuggestList[index].avatarImage,
          name: _sendMoneySuggestList[index].name
      ));
    }
    else if(transactionType == 'request_money'){
      setContactModel(ContactModel(
          phoneNumber: _requestMoneySuggestList[index].phoneNumber,
          avatarImage: _requestMoneySuggestList[index].avatarImage,
          name: _requestMoneySuggestList[index].name
      ));
    }
    else if(transactionType == 'cash_out'){
      setContactModel(ContactModel(
          phoneNumber: _cashOutSuggestList[index].phoneNumber,
          avatarImage: _cashOutSuggestList[index].avatarImage,
          name: _cashOutSuggestList[index].name
      ));
    }

    Get.to(()=>TransactionMoneyBalanceInput(transactionType: transactionType));

    }

  void balanceConfirmationOnTap({double amount, String transactionType, String purpose, ContactModel contactModel}) {
    Get.to(()=> TransactionMoneyConfirmation(
        inputBalance: amount, transactionType: transactionType, contactModel: contactModel));
  }



  void getSuggestList()async{
    _sendMoneySuggestList = [];
    _sendMoneySuggestList.addAll(transactionRepo.getSuggestList());

  }

  void changeTrueFalse(){
    _isNextBottomSheet = false;
  }

  Future<Response> pinVerify({@required String pin})async{
    _isLoading = true;
     update();
    final Response response =  await authRepo.pinVerifyApi(pin: pin);
    if(response.statusCode == 200){
      _isLoading = false;
    }else{
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }


  Future<bool> getBackScreen()async{
    Get.offAndToNamed(RouteHelper.navbar, arguments: false);
    return null;
  }


}