import 'package:six_cash/controller/image_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/data/model/body/edit_profile_body.dart';
import 'package:six_cash/data/model/response/response_model.dart';
import 'package:six_cash/data/repository/auth_repo.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  EditProfileController({@required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _image ;
  String get image => _image;
  setImage(String image){
    _image = image;
  }

  ///gender
  String _gender;
  String get gender => _gender;

  setGender(String select){
    _gender = select;
    update();
    print(_gender);
  }

  ///occupation
  String _occupation ;
  String get occupation => _occupation;
  setSelect(String occupation){
    _occupation = occupation;
    update();
    print(_occupation);
  }

  Future<ResponseModel> updateProfileData(EditProfileBody editProfileBody,List<MultipartBody> multipartBody) async{

    _isLoading = true;
    update();

    Map<String, String> _allProfileInfo = {
      'f_name': editProfileBody.fName,
      'l_name': editProfileBody.lName,
      'email': editProfileBody.email,
      'gender': editProfileBody.gender,
      'occupation': editProfileBody.occupation,
      '_method': 'put',
    };
    Map<String, String> _sortOutProfileInfo = {
      'f_name': editProfileBody.fName,
      'l_name': editProfileBody.lName,
      'gender': editProfileBody.gender,
      'occupation': editProfileBody.occupation,
      '_method': 'put',
    };
    Map<String, String> _profileInfo = Map();
    if(editProfileBody.email == ''){
      _profileInfo.addAll(_sortOutProfileInfo);
    }else{
      bool _emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(editProfileBody.email);

      if(_emailValid == true){
        _profileInfo.addAll(_allProfileInfo);
      }
      else{
        showCustomSnackBar('please_provide_valid_email'.tr);
        _isLoading = false;
        update();
      }
    }

    Response response = await authRepo.updateProfile(_profileInfo,multipartBody);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body['message']);
      if(Get.find<ImageController>().getImage != null) {
        Get.find<ImageController>().removeImage();
      }
      Get.find<ProfileController>().profileData(loading: true);
      Get.back();
      print(responseModel.message);
      showCustomSnackBar(
          responseModel.message,
          isError: false);
    }
    else {
      /*responseModel = ResponseModel(false, response.statusText);
      print(response.body['errors'][0]['message']);
      responseModel = ResponseModel(false, response.body['errors'][0]['message']);
      showCustomSnackBar(
          responseModel.message,
          isError: true);
      Get.back();*/
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    print(isLoading);
    return responseModel;
  }



}