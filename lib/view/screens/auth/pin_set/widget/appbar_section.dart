import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/base/custom_logo.dart';

class AppbarSection extends StatelessWidget {
  final bool isLogin;
  const AppbarSection({Key key,@required this.isLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
        right: Dimensions.PADDING_SIZE_LARGE,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomLogo(
            height: Dimensions.SMALL_LOGO,
            width: Dimensions.SMALL_LOGO,
          ),
          isLogin
              ?Container(

                decoration: BoxDecoration(
                  color: ColorResources.getSecondaryHeaderColor(),
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_EXTRA_LARGE),),
                child: CustomInkWell(
                  onTap: (){
                    Get.toNamed(RouteHelper.getChoseLanguageRoute());
                  },
                  radius: Dimensions.RADIUS_SIZE_EXTRA_LARGE,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_SMALL,),
                    child: Text(
                      'language'.tr,
                      style: rubikRegular.copyWith(
                        color: ColorResources.getPrimaryColor(),
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      ),
                    ),
                  ),
                ),
              )
          : Container(),
        ],
      ),
    );
  }
}
