import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputSecton extends StatelessWidget {

  final TextEditingController fNameController,lNameController,emailController;
   InputSecton({Key key, this.fNameController, this.lNameController, this.emailController}) : super(key: key);




  final FocusNode lastNameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller){
      return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_LARGE,
          vertical: Dimensions.PADDING_SIZE_LARGE),
      child: Column(
        children: [
          TextField(
            controller: fNameController,
            onSubmitted: (value){
              FocusScope.of(context).requestFocus(lastNameFocus);
            },
            // keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'first_name'.tr,
              hintStyle: rubikRegular.copyWith(
                color: ColorResources.hintColor,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
          ),
          const SizedBox(
            height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
          ),
          TextField(
            controller: lNameController,
            focusNode: lastNameFocus,
            // keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'last_name'.tr,
              hintStyle: rubikRegular.copyWith(
                color: ColorResources.hintColor,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
          ),
          const SizedBox(
            height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
          ),
          Row(
           
            children: [
              Text(
                'email_address'.tr,
                style: rubikMedium.copyWith(
                  color: ColorResources.getBlackColor(),
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                ),
              ),

              Text(
                'optional'.tr,
                style: rubikRegular.copyWith(
                  color: ColorResources.getPrimaryTextColor(),
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
          ),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'type_email_address'.tr,
              hintStyle: rubikLight.copyWith(
                color: ColorResources.hintColor,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
          ),
        ],
      ),
    );
    });
  }
}
