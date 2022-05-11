import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/edit_profile_controller.dart';
import 'package:six_cash/controller/image_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/data/model/body/edit_profile_body.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_small_button.dart';
import 'package:six_cash/view/base/custom_text_field.dart';
import 'package:six_cash/view/screens/profile/widget/gender_section.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController occupationTextController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final FocusNode occupationFocus = FocusNode();
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailNameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    ProfileController profileController = Get.find<ProfileController>();
    occupationTextController.text = profileController.userInfo.occupation ?? '';
    firstNameController.text = profileController.userInfo.fName ?? '';
    lastNameController.text = profileController.userInfo.lName ?? '';
    emailController.text = profileController.userInfo.email ?? '';
    Get.find<EditProfileController>().setGender(profileController.userInfo.gender ?? 'Male') ;
    Get.find<EditProfileController>().setImage(profileController.userInfo.image ?? '') ;
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(builder: (controller) {

      return SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: controller.isLoading,
          progressIndicator: CircularProgressIndicator(color: Theme.of(context).primaryColor),
          child: WillPopScope(
            onWillPop: ()=> _onWillPop(context),
            child: Scaffold(
              appBar: CustomAppbar(title: 'edit_profile'.tr,onTap: (){
                if(Get.find<ImageController>().getImage != null){
                  Get.find<ImageController>().removeImage();
                }

                Get.back();
              },),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_LARGE,
                          ),
                          Stack(
                            clipBehavior: Clip.none, children: [
                            GetBuilder<ImageController>(builder: (imageController){
                              return imageController.getImage == null ?
                              GetBuilder<ProfileController>(builder: (proController){
                                return Container( height: 100,width: 100,
                                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(100)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: FadeInImage.assetNetwork(
                                        imageErrorBuilder: (c, o, s) => Image.asset(Images.avatar, fit: BoxFit.cover),
                                        placeholder: Images.avatar,
                                        height: 100, width: 100,
                                        fit: BoxFit.cover,
                                        image : '${Get.find<SplashController>().configModel.baseUrls.agentImageUrl}/${proController.userInfo.image}'),
                                  ),
                                );
                              })
                                  :  Container(
                                height: 100,width: 100,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: ColorResources.getPrimaryTextColor(),width: 2),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:FileImage(
                                        File(imageController.getImage.path),
                                      ),
                                    )
                                ),
                              );
                            },),


                            Positioned(
                              bottom: 5,
                              right: -5,
                              child: InkWell(
                                onTap: ()=> Get.find<AuthController>().requestCameraPermission(fromEditProfile: true),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorResources.getWhiteColor(),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorResources.getShadowColor().withOpacity(0.08),
                                          blurRadius: 20,
                                          offset: const Offset(0, 3),
                                        )
                                      ]
                                  ),
                                  child: Icon(Icons.camera_alt,size: 24,),

                                ),
                              ),

                            )
                          ],
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_LARGE,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                            child: GenderSection(),
                          ),

                          GetBuilder<ProfileController>(builder: (controller){
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_LARGE,
                                  vertical: Dimensions.PADDING_SIZE_LARGE),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2), child: Text('occupation'.tr),
                                  ),
                                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                  CustomTextField(
                                    fillColor: Theme.of(context).cardColor,
                                    hintText: 'occupation'.tr,
                                    isShowBorder: true,
                                    controller: occupationTextController,
                                    focusNode: occupationFocus,
                                    nextFocus: firstNameFocus,
                                    inputType: TextInputType.name,
                                    capitalization: TextCapitalization.words,
                                  ),
                                  const SizedBox(
                                    height: Dimensions.PADDING_SIZE_LARGE,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2), child: Text('first_name'.tr),
                                  ),
                                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                  CustomTextField(
                                    fillColor: Theme.of(context).cardColor,
                                    hintText: 'first_name'.tr,
                                    isShowBorder: true,
                                    controller: firstNameController,
                                    focusNode: firstNameFocus,
                                    nextFocus: lastNameFocus,
                                    inputType: TextInputType.name,
                                    capitalization: TextCapitalization.words,
                                  ),
                                  const SizedBox(
                                    height: Dimensions.PADDING_SIZE_LARGE,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2), child: Text('last_name'.tr),
                                  ),
                                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                  CustomTextField(
                                    fillColor: Theme.of(context).cardColor,
                                    hintText: 'last_name'.tr,
                                    isShowBorder: true,
                                    controller: lastNameController,
                                    focusNode: lastNameFocus,
                                    nextFocus: emailNameFocus,
                                    inputType: TextInputType.name,
                                    capitalization: TextCapitalization.words,
                                  ),
                                  const SizedBox(
                                    height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
                                  ),

                                   Column(
                                    children: [

                                      Row(
                                        children: [
                                          Text('email_address'.tr, style: rubikMedium.copyWith(
                                            fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                          ),
                                          ),

                                          Text('optional'.tr, style: rubikRegular.copyWith(
                                            color: ColorResources.getPrimaryTextColor(),
                                            fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                          ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: Dimensions.PADDING_SIZE_LARGE,
                                      ),

                                      CustomTextField(
                                        fillColor: Theme.of(context).cardColor,
                                        hintText: 'type_email_address'.tr,
                                        isShowBorder: true,
                                        controller: emailController,
                                        focusNode: emailNameFocus,
                                        inputType: TextInputType.emailAddress,
                                      ),
                                    ],
                                  ) ,

                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    ),

                  ),
                  Container(
                    padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, bottom: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomSmallButton(
                            onTap: () {
                              _saveProfile(controller);
                            },
                            backgroundColor: ColorResources.getSecondaryHeaderColor(),
                            text: 'save'.tr,
                            textColor: ColorResources.getBlackColor(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
  Future _onWillPop(BuildContext context) async {
    if(Get.find<ImageController>().getImage != null){
      Get.find<ImageController>().removeImage();
      print('====> Remove image from controller');
      return Get.back();
    }
    else{
      return Get.back();
    }
  }
  _saveProfile(EditProfileController controller){
    String _fName = firstNameController.text;
    String _lName = lastNameController.text;
    String _email = emailController.text;
    String _gender = controller.gender;
    String _occupation = occupationTextController.text;
    File _image = Get.find<ImageController>().getImage;


    List<MultipartBody> _multipartBody;
    if(_image != null){
      _multipartBody = [MultipartBody('image',_image )];
    }else{
      _multipartBody = [];
    }

    EditProfileBody editProfileBody  = EditProfileBody(fName: _fName, lName: _lName, gender: _gender, occupation: _occupation, email: _email);
    controller.updateProfileData(editProfileBody, _multipartBody);
    Get.find<ProfileController>().profileData();
  }
}
