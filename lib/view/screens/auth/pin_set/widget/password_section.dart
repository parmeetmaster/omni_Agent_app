import 'package:six_cash/controller/image_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordFieldsSection extends StatelessWidget {
  final TextEditingController passController, confirmPassController;
  PasswordFieldsSection({Key key,@required this.passController,@required this.confirmPassController}) : super(key: key);
  final FocusNode confirmFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
          vertical: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorResources.getWhiteColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE),
            topRight: Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE),
                child: Text(
                  'set_your_4_digit_PIN_for_future_login'.tr,
                  textAlign: TextAlign.center,
                  style: rubikMedium.copyWith(
                    color: ColorResources.getPrimaryTextColor(),
                    fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimensions.PADDING_SIZE_EXTRA_OVER_LARGE,
              ),
              CustomPasswordField(
                controller: passController,
                nextFocus: confirmFocus,
                isPassword: true,
                isShowSuffixIcon: true,
                isIcon: false,
                hint: 'set_your_PIN'.tr,
                letterSpacing: 10.0,

              ),
              const SizedBox(
                height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
              ),
              CustomPasswordField(
                controller: confirmPassController,
                focusNode: confirmFocus,
                hint: 'confirm_PIN'.tr,
                isShowSuffixIcon: true,
                isPassword: true,
                isIcon: false,
                letterSpacing: 10.0,

              ),

            ],
          ),
        ),
      );
    });
  }
}