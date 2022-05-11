import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_number/phone_number.dart';
import 'package:six_cash/controller/image_controller.dart';
import 'package:six_cash/controller/selfie_controller.dart';
import 'package:six_cash/controller/varification_controller.dart';
import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/data/model/body/signup_body.dart';
import 'package:six_cash/data/model/response/response_model.dart';
import 'package:six_cash/data/repository/auth_repo.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({@required this.authRepo});
    bool _isLoading = false;
    bool _isVerifying = false;
    bool get isLoading => _isLoading;
    bool get isVerifying => _isVerifying;
    Future<Response> checkPhone(String phoneNumber) async{
      _isLoading = true;
      update();
      Response response = await authRepo.sendPhoneNumber(phoneNumber: phoneNumber);
      if(response.statusCode == 200){
        if(response.body['otp'] == "active"){
          Get.find<VarificationController>().startTimer();
          Get.toNamed(RouteHelper.getVerifyRoute());
        }
        _isLoading = false;
        update();
      }
      else if(response.statusCode == 403){
        String _countryCode;
        String _nationalNumber;
        try{
          PhoneNumber _number = await PhoneNumberUtil().parse(phoneNumber);
           _countryCode = '+' + _number.countryCode;
           _nationalNumber = _number.nationalNumber;
        }
        catch(e){

        }

        Get.offNamed(RouteHelper.getLoginRoute(countryCode: _countryCode,phoneNumber: _nationalNumber));
        _isLoading = false;

      }
      else{
        ApiChecker.checkApi(response);
      }
      update();
      return response;
    }
  Future<Response> resendOtp({@required String phoneNumber}) async{
    _isLoading = true;
    update();
    Response response = await authRepo.resendOtp(phoneNumber: phoneNumber);
    if(response.statusCode == 200){
      _isLoading = false;
    }
    else{
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }

    /// Camera permission......
  Future<void> requestCameraPermission({@required bool fromEditProfile}) async {
    var serviceStatus = await Permission.camera.status;
    if(serviceStatus.isGranted){
      Get.offNamed(RouteHelper.getSelfieRoute(fromEditProfile: fromEditProfile));
    }else{
      final status = await Permission.camera.request();
      if (status == PermissionStatus.granted) {
        Get.offNamed(RouteHelper.getSelfieRoute(fromEditProfile: fromEditProfile));
      } else if (status == PermissionStatus.denied) {
        Get.find<SelfieController>().showDeniedDialog(fromEditProfile: fromEditProfile);
      } else if (status == PermissionStatus.permanentlyDenied) {
        Get.find<SelfieController>().showPermanentlyDeniedDialog(fromEditProfile: fromEditProfile);
      }
    }


  }

    //Phone Number verification
  Future<ResponseModel> phoneVerify(String phoneNumber,String otp) async{
    print('==number==> '+ phoneNumber + '==otp==>' + otp);
    _isLoading = true;
    update();
    Response response = await authRepo.verifyPhoneNumber(phoneNumber: phoneNumber, otp: otp);

    ResponseModel responseModel;
    print(response.statusCode);
    if(response.statusCode == 200){
      print(response.body['message']);
      print(response.statusText);
      responseModel = ResponseModel(true, response.body["message"]);
      Get.find<VarificationController>().cancelTimer();
      showCustomSnackBar(
          responseModel.message,
          isError: false);
      // Get.offNamed(RouteHelper.getSelfieRoute(fromEditProfile: false));
      // Get.to(SelfieCaptureScreen(fromEditProfile: false));

      requestCameraPermission(fromEditProfile: false);
    }
    else{
      print(response.body['errors'][0]['message']);
      responseModel = ResponseModel(false, response.body['errors'][0]['message']);
      showCustomSnackBar(
          responseModel.message,
          isError: true);
    }
    _isLoading = false;
    update();
    return responseModel;
  }


  // registration ..
  Future<Response> registration(SignUpBody signUpBody,List<MultipartBody> multipartBody) async{
      _isLoading = true;
      update();
      Map<String, String> _allCustomerInfo = {
        'f_name': signUpBody.fName,
        'l_name': signUpBody.lName,
        'email': signUpBody.email,
        'phone': signUpBody.phone,
        'password': signUpBody.password,
        'referral_id': /*signUpBody.referralId*/ '0',
        'otp': signUpBody.otp,
        'gender': signUpBody.gender,
        'occupation': signUpBody.occupation,
      };
      Map<String, String> _sortOutCustomerInfo = {
        'f_name': signUpBody.fName,
        'l_name': signUpBody.lName,
        'phone': signUpBody.phone,
        'password': signUpBody.password,
        'otp': signUpBody.otp,
        'gender': signUpBody.gender,
        'occupation': signUpBody.occupation,
      };
      Map<String, String> _customerInfo = Map();
      if(signUpBody.email == '' /*|| signUpBody.referralId == null*/){
        _customerInfo.addAll(_sortOutCustomerInfo);

      }else{
        _customerInfo.addAll(_allCustomerInfo);

      }

      Response response = await authRepo.registration(_customerInfo,multipartBody);
      if (response.statusCode == 200) {
        Get.find<ImageController>().removeImage();
        String _countryCode, _nationalNumber;
        try{
          PhoneNumber _phoneNumber = await PhoneNumberUtil().parse(signUpBody.phone);
           _countryCode = '+' + _phoneNumber.countryCode;
           _nationalNumber = _phoneNumber.nationalNumber;
        }catch(e){}
        setCustomerCountryCode(_countryCode);
        setUserNumber(_nationalNumber);
        _isLoading = false;
        Get.offAllNamed(RouteHelper.getWelcomeRoute(countryCode: getCustomerCountryCode(),phoneNumber: getUserNumber()));
      } else {
        _isLoading = false;
        ApiChecker.checkApi(response);
      }
      update();
      return response;
  }

  Future<Response> login({String code, String phone, String password}) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(phone: '$code$phone', password: password);
    if (response.statusCode == 200 && response.body['token'] != null) {
       authRepo.saveUserToken(response.body['token']);
      setCustomerCountryCode(code);
      setUserNumber(phone);
      Get.offAllNamed(RouteHelper.getNavBarRoute(), arguments: true);
      _isLoading = false;
    }
    else{
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }
  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  Future<Response> checkOtp()async{
      _isLoading = true;
      update();
      Response  response = await authRepo.checkOtpApi();
      if(response.statusCode == 200){
        _isLoading = false;
      }else{
        _isLoading = false;
        ApiChecker.checkApi(response);
      }
      update();
      return response;
  }

  Future<Response> verifyOtp(String otp)async{
    _isVerifying = true;
    update();
    Response  response = await authRepo.verifyOtpApi(otp: otp);
    if(response.statusCode == 200){
      _isVerifying = false;
      Get.back();
    }else{
      ApiChecker.checkApi(response);
      _isVerifying = false;
    }
    update();
    return response;
  }


  Future<Response> logout() async {
    _isLoading = true;
    update();
    Response response = await authRepo.logout();
    if (response.statusCode == 200) {

      Get.offAllNamed(RouteHelper.getSplashRoute());
      _isLoading = false;
    }
    else{
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }

  Future<ResponseModel> otpForForgetPass(String phoneNumber, BuildContext context) async{
    _isLoading = true;
    update();
    Response response = await authRepo.forgetPassOtp(phoneNumber: phoneNumber);
    ResponseModel responseModel;
    print(response.statusCode);
    if(response.statusCode == 200){
      _isLoading = false;
      Get.toNamed(RouteHelper.getFVeryficationRoute(phoneNumber: phoneNumber));
    }
    else{
      _isLoading = false;
      ApiChecker.checkApi(response);

    }
    update();
    return responseModel;
  }

  Future<Response> verificationForForgetPass(String phoneNumber, String otp, BuildContext context) async{
    _isLoading = true;
    update();
    Response response = await authRepo.forgetPassVerification(phoneNumber: phoneNumber,otp: otp);
    if(response.statusCode == 200){
      _isLoading = false;
      Get.offNamed(RouteHelper.getFResetPassRoute(phoneNumber: phoneNumber));
    }
    else{
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }

  Future<Response> resetPassword(String phoneNumber, String otp, String newPass, String confirmPass) async{
    _isLoading = true;
    update();
    Response response = await authRepo.forgetPassReset(phoneNumber: phoneNumber,otp: otp,password: newPass,confirmPass: confirmPass);
    if(response.statusCode == 200){
      _isLoading = false;
      String _countryCode , _nationalNumber;
      try{
        PhoneNumber num = await PhoneNumberUtil().parse(phoneNumber);
        _countryCode = '+' + num.countryCode;
        _nationalNumber = num.nationalNumber;
        Get.offAllNamed(RouteHelper.getLoginRoute(countryCode: _countryCode,phoneNumber: _nationalNumber));
      }catch(e){
        showCustomSnackBar('something_error_in_your_phone_number'.tr, isError: false);
      }
    }
    else{
      _isLoading = false;
     ApiChecker.checkApi(response);
    }
    update();
    return response;
  }

  String getAuthToken() {
    return authRepo.getUserToken();
  }


  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  void setCustomerName(String name){
      authRepo.saveCustomerName(name);
  }
  void setCustomerCountryCode(String code){
    authRepo.saveCustomerCountryCode(code);
  }
  void setUserNumber(String number){
    authRepo.saveUserNumber(number);
  }
  void setCustomerQrCode(String qrCode){
    authRepo.saveCustomerQrCode(qrCode);
  }
  String getCustomerName(){
      return authRepo.getCustomerName();
  }
  String getUserNumber(){
    return authRepo.getUserNumber();
  }
  String getCustomerCountryCode(){
    return authRepo.getCustomerCountryCode();
  }
  String getCustomerQrCode(){
    return authRepo.getCustomerQrCode();
  }
  void removeCustomerName() {
     authRepo.removeCustomerName();
  }
  void removeCustomerNumber() {
    authRepo.removeCustomerNumber();
  }
  void removeCustomerQrCode() {
    authRepo.removeCustomerQrCode();
  }

  void removeCustomerToken() {
    authRepo.removeCustomerToken();
  }

  PageController pageController = PageController();
  int _page = 0;

  int get page => _page;
  change(int a) {
    _page = a;
    update();
  }
}
