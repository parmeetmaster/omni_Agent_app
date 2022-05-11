import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/home_controller.dart';
import 'package:six_cash/controller/menu_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/view/screens/home/widget/animated_card/custom_rect_tween.dart';
import 'package:six_cash/view/screens/home/widget/animated_card/hero_dialogue_route.dart';
import 'package:six_cash/view/screens/home/widget/animated_card/qr_popup_card.dart';
import 'package:six_cash/view/screens/home/widget/show_balance.dart';

class AppBarBase extends StatelessWidget implements PreferredSizeWidget {
  AppBarBase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return Container(
          color: ColorResources.getPrimaryColor(),


          child: Container(
            padding: const EdgeInsets.only(top: 54, left: Dimensions.PADDING_SIZE_LARGE, right: Dimensions.PADDING_SIZE_LARGE, bottom: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(color: ColorResources.whiteColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_LARGE)),
            ),


            child: Row(
              children: [
                GestureDetector(onTap: (){Get.find<MenuController>().selectProfilePage();},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                      height: Dimensions.RADIUS_SIZE_OVER_LARGE, width: Dimensions.RADIUS_SIZE_OVER_LARGE,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:profileController.userInfo != null? FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        image: "${Get.find<SplashController>().configModel.baseUrls.agentImageUrl}/${profileController.userInfo.image}",
                        placeholder: Images.avatar,
                        imageErrorBuilder: (context, imageProvider,err) => Image.asset(Images.avatar))
                          : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),child: ClipRRect( borderRadius: BorderRadius.circular(10),
                          child: Image.asset(Images.avatar,fit: BoxFit.cover,))),
                    ))),


                const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                ShowBalance(profileController:profileController),
                const Spacer(),


                GestureDetector(onTap: () => Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                      return QrPopupCard();})),



                  child: Hero(tag: Get.find<HomeController>().heroShowQr,
                    createRectTween: (begin, end) {return CustomRectTween(begin: begin, end: end);},


                    child: Container(padding: const EdgeInsets.all(Dimensions.FONT_SIZE_DEFAULT),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: ColorResources.whiteColor,),
                      child: profileController.userInfo !=null ? SvgPicture.string(
                        profileController.userInfo.qrCode, height: Dimensions.PADDING_SIZE_LARGE, width: Dimensions.PADDING_SIZE_LARGE,


                      ):Container(height: Dimensions.PADDING_SIZE_LARGE,
                          width: Dimensions.PADDING_SIZE_LARGE,
                          child: Image.asset(Images.qrCode)),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 200);
}
