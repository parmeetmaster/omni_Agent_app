import 'package:country_code_picker/country_code_picker.dart';
import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/model/response/config_model.dart';
import 'package:six_cash/data/repository/splash_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SplashController extends GetxController implements GetxService{
   final SplashRepo splashRepo;
  SplashController({@required this.splashRepo});

  ConfigModel _configModel;

  DateTime _currentTime = DateTime.now();

  DateTime get currentTime => _currentTime;
  bool _firstTimeConnectionCheck = true;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  ConfigModel get configModel => _configModel;

  Future<Response> getConfigData() async {
    Response _response = await splashRepo.getConfigData();
    if(_response.hasError) {
      ApiChecker.checkApi(_response);
    }else {
      //Get.showSnackbar(GetBar(title: 'response', message: '${_response.body}'));
     _configModel =  ConfigModel.fromJson(_response.body);
     print('splash:  ${configModel.baseUrls.customerImageUrl}');
     print('splash banner url:  ${configModel.baseUrls.bannerImageUrl}');
     update();

    }
    return _response;
  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  Future<bool> removeSharedData() {
    return splashRepo.removeSharedData();
  }

  bool isRestaurantClosed() {
    DateTime _open = DateFormat('hh:mm').parse('');
    DateTime _close = DateFormat('hh:mm').parse('');
    DateTime _openTime = DateTime(_currentTime.year, _currentTime.month, _currentTime.day, _open.hour, _open.minute);
    DateTime _closeTime = DateTime(_currentTime.year, _currentTime.month, _currentTime.day, _close.hour, _close.minute);
    if(_closeTime.isBefore(_openTime)) {
      _closeTime = _closeTime.add(Duration(days: 1));
    }
    if(_currentTime.isAfter(_openTime) && _currentTime.isBefore(_closeTime)) {
      return false;
    }else {
      return true;
    }
  }


  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  String getCountryCode (){
    CountryCode countryCode =  CountryCode.fromCountryCode(Get.find<SplashController>().configModel.country);
    String _countryCode = countryCode.toString();
    return _countryCode;
  }
}
