
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/util/app_constants.dart';

class AuthRepo extends GetxService{
   final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({@required this.apiClient, @required this.sharedPreferences});


  Future<Response> sendPhoneNumber({String phoneNumber}) async {
    return apiClient.postData(AppConstants.AGENT_PHONE_CHECK_URI, {"phone": phoneNumber});
  }
   Future<Response> resendOtp({String phoneNumber}) async {
     return apiClient.postData(AppConstants.AGENT_PHONE_RESEND_OTP_URI, {"phone": phoneNumber});
   }
  
  Future<Response> verifyPhoneNumber({String phoneNumber,String otp}) async {
    return apiClient.postData(AppConstants.AGENT_PHONE_VERIFY_URI, {"phone": phoneNumber, "otp": otp});
  }
   Future<Response> registration(Map<String,String> customerInfo,List<MultipartBody> multipartBody) async {
     return await apiClient.postMultipartData(AppConstants.CUSTOMER_REGISTRATION_URI, customerInfo,multipartBody);
   }
   Future<Response> login({String phone, String password}) async {
     return await apiClient.postData(AppConstants.AGENT_LOGIN_URI, {"phone": phone, "password": password});
   }

   Future<Response> updateToken() async {
     String _deviceToken;
     if (GetPlatform.isIOS) {
       NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
         alert: true, announcement: false, badge: true, carPlay: false,
         criticalAlert: false, provisional: false, sound: true,
       );
       if(settings.authorizationStatus == AuthorizationStatus.authorized) {
         _deviceToken = await _saveDeviceToken();
         FirebaseMessaging.instance.subscribeToTopic(AppConstants.ALL);
         FirebaseMessaging.instance.subscribeToTopic(AppConstants.AGENT);
         debugPrint('=========>Device Token ======$_deviceToken');
       }
     }else {
       _deviceToken = await _saveDeviceToken();
       FirebaseMessaging.instance.subscribeToTopic(AppConstants.ALL);
       FirebaseMessaging.instance.subscribeToTopic(AppConstants.AGENT);
       debugPrint('=========>Device Token ======$_deviceToken');
     }
     if(!GetPlatform.isWeb) {
       // FirebaseMessaging.instance.subscribeToTopic('six_cash');
       FirebaseMessaging.instance.subscribeToTopic(AppConstants.ALL);
       FirebaseMessaging.instance.subscribeToTopic(AppConstants.AGENT);
     }
     return await apiClient.postData(AppConstants.TOKEN_URI, {"_method": "put", "token": _deviceToken},
       headers:  {
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': 'Bearer ${sharedPreferences.get(AppConstants.TOKEN)}'
       },
     );
   }


   Future<String> _saveDeviceToken() async {
     String _deviceToken = '';
     if(!GetPlatform.isWeb) {
       _deviceToken = await FirebaseMessaging.instance.getToken();
     }
     if (_deviceToken != null) {
     }
     return _deviceToken;
   }


   Future<Response>  checkOtpApi() async {
     return await apiClient.postData(AppConstants.AGENT_CHECK_OTP,{});
   }

   Future<Response>  verifyOtpApi({@required String otp}) async {
     return await apiClient.postData(AppConstants.AGENT_VERIFY_OTP, {'otp': otp });
   }


   Future<Response> logout() async {
     return await apiClient.postData(AppConstants.AGENT_LOGOUT_URI,{});
   }
   Future<Response> updateProfile(Map<String,String> profileInfo,List<MultipartBody> multipartBody) async {
     return await apiClient.postMultipartData(AppConstants.AGENT_UPDATE_PROFILE, profileInfo,multipartBody);
   }
   Future<Response>  pinVerifyApi({@required String pin}) async {
     return await apiClient.postData(AppConstants.AGENT_PIN_VERIFY,{'pin': pin});
   }

   Future<bool> saveUserToken(String token) async {
     apiClient.token = token;
     apiClient.updateHeader(token, null);
     return await sharedPreferences.setString(AppConstants.TOKEN, token);
   }

   ///for customer information
   // Future<void> saveCustomerNumberAndName(String number, String name, String countryCode) async {
   //     try {
   //       await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
   //       await sharedPreferences.setString(AppConstants.USER_NUMBER, number);
   //       await sharedPreferences.setString(AppConstants.USER_COUNTRY_CODE, countryCode);
   //     } catch (e) {
   //       throw e;
   //     }
   //   }
   Future<void> saveCustomerName(String name) async{
    try{
      await sharedPreferences.setString(AppConstants.AGENT_NAME, name);
    }
    catch(e){
      throw e;
    }
   }
   Future<void> saveCustomerCountryCode(String code) async{
     try{
       await sharedPreferences.setString(AppConstants.COUNTRY_CODE, code);
     }
     catch(e){
       throw e;
     }
   }
   Future<void> saveUserNumber(String number) async{
     try{
       await sharedPreferences.setString(AppConstants.AGENT_NUMBER, number);
     }
     catch(e){
       throw e;
     }
   }
   Future<void> saveCustomerQrCode(String qrCode) async{
     try{
       await sharedPreferences.setString(AppConstants.AGENT_QR_CODE, qrCode);
     }
     catch(e){
       throw e;
     }
   }

   String getUserToken() {
     return sharedPreferences.getString(AppConstants.TOKEN) ?? null;
   }
   bool isLoggedIn() {
     return sharedPreferences.containsKey(AppConstants.TOKEN);
   }
   void removeUserToken()async{
     await sharedPreferences.remove(AppConstants.TOKEN);
   }

   String getCustomerName() {
    print('===Customer name=====>${sharedPreferences.getString(AppConstants.AGENT_NAME)}');
     return sharedPreferences.getString(AppConstants.AGENT_NAME) ?? '';
   }
   void removeCustomerName() async{
     print('name remove');
     await sharedPreferences.remove(AppConstants.AGENT_NAME);
   }
   String getCustomerCountryCode() {
     return sharedPreferences.getString(AppConstants.COUNTRY_CODE) ?? '';
   }
   void removeCustomerCountryCode() async{
     print('country code remove');
     await sharedPreferences.remove(AppConstants.COUNTRY_CODE);
   }
   String getUserNumber() {
     return sharedPreferences.getString(AppConstants.AGENT_NUMBER) ?? '';
   }
   void removeCustomerNumber() async{
    print('number remove');
     await sharedPreferences.remove(AppConstants.AGENT_NUMBER);
   }
   String getCustomerQrCode() {
     return sharedPreferences.getString(AppConstants.AGENT_QR_CODE) ?? '';
   }
   void removeCustomerQrCode() async{
     print('qr remove');
     await sharedPreferences.remove(AppConstants.AGENT_QR_CODE);
   }
   void removeCustomerToken() async{
     print('token remove');
     await sharedPreferences.remove(AppConstants.TOKEN);
   }

   // for Forget password
   Future<Response> forgetPassOtp({String phoneNumber}) async {
     return apiClient.postData(AppConstants.AGENT_FORGET_PASS_OTP_URI, {"phone": phoneNumber});
   }
   Future<Response> forgetPassVerification({String phoneNumber, String otp}) async {
     return apiClient.postData(AppConstants.AGENT_FORGET_PASS_VERIFICATION, {"phone": phoneNumber, "otp": otp});
   }
   Future<Response> forgetPassReset({String phoneNumber, String otp, String password, String confirmPass}) async {
     return apiClient.putData(AppConstants.AGENT_FORGET_PASS_RESET, {"phone": phoneNumber, "otp": otp, "password": password, "confirm_password": confirmPass});
   }


}