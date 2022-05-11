import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/screens/profile/widget/confirm_pin_bottom_sheet.dart';

class TwoFactorMenu extends StatelessWidget {
  const TwoFactorMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () => Get.defaultDialog(barrierDismissible: false, title: '4digit_pin'.tr, content: ConfirmPinBottomSheet()),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL,horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        child: Row(children: [
          Image.asset(Images.two_factor_authentication,width: 28.0),
          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
          Text('two_factor_authentication'.tr,style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
          Spacer(),
          GetBuilder<ProfileController>(builder: (profController)=> profController.isLoading ? Center(child: Text('off'.tr)) : Text(profController.userInfo.twoFactor ? 'on'.tr : 'off'.tr)),
          //Image.asset(Images.arrow_right_logo,width: 32.0,)

        ],),
      ),

    );
  }
}

class TwoFactorShimmer extends StatelessWidget {
  const TwoFactorShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Shimmer.fromColors(baseColor: ColorResources.shimmerBaseColor, highlightColor:  ColorResources.shimmerLightColor,
        child : Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL,horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Row(children: [
            Image.asset(Images.two_factor_authentication,width: 28.0),
            SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
            Text('two_factor_authentication'.tr,style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
            Spacer(),
            GetBuilder<ProfileController>(builder: (profController)=> profController.isLoading ? Center(child: Text('off'.tr)) : Text(profController.userInfo.twoFactor ? 'on'.tr : 'off'.tr)),
            //Image.asset(Images.arrow_right_logo,width: 32.0,)

          ],),
        ),
      ),
    );
  }
}

