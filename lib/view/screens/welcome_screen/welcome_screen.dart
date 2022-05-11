import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_logo.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  final String phoneNumber,countryCode;
  const WelcomeScreen({Key key, this.phoneNumber, this.countryCode}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      ///TODO:
      Get.offAllNamed(RouteHelper.getLoginRoute(countryCode: widget.countryCode,phoneNumber: widget.phoneNumber));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResources.getPrimaryColor(),
      //appBar: CustomWhiteAppbar(onTap: (){Get.back();},),
      body: Container(
        height: size.height * 0.7,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
        decoration: BoxDecoration(
          color: ColorResources.getWhiteColor(),
          borderRadius: BorderRadius.only(
            bottomLeft:
                Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE),
            bottomRight:
                Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLogo(
              height: 90,
              width: 90,
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
            ),
             Text(
                'Welcome to FirstPay!',
                textAlign: TextAlign.center,
                style: rubikMedium.copyWith(
                  color: ColorResources.getPrimaryTextColor(),
                  fontSize: Dimensions.FONT_SIZE_OVER_OVER_LARGE,
                ),
              ),
              const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            // Text(
            //     'Hello, Mehedi!',
            //     textAlign: TextAlign.center,
            //     style: rubikRegular.copyWith(
            //       color: ColorResources.getGreyBaseGray1(),
            //       fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
            //     ),
            //   ),
              const SizedBox(
              height: Dimensions.PADDING_SIZE_OVER_LARGE,
            ),
             Text(
                'start_exploring_the_amazing_ways_to_take_your_lifestyle_upward'.tr,
                textAlign: TextAlign.center,
                style: rubikLight.copyWith(
                  color: ColorResources.getBlackColor(),
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                ),
              ),
               const SizedBox(
              height: Dimensions.PADDING_SIZE_OVER_LARGE,
            ),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 50,right: 10),
      //   child: FloatingActionButton(
      //
      //     onPressed: () {
      //       Get.toNamed(RouteHelper.login_screen);
      //     },
      //     elevation: 0,
      //     backgroundColor: ColorResources.getSsecondaryHeaderColor(),
      //     child: SizedBox(
      //       height: 20.33,
      //       width: 20.33,
      //       child: Image.asset(Images.arrow_right),
      //     ),
      //   ),
      // ),
    );
  }
}
