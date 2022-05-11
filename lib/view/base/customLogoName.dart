import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';

class CustomLogoName extends StatelessWidget {
  final Color textColor;
  const CustomLogoName({Key key, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(Images.logo, height: 100),
        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

        Text('${Get.find<SplashController>().configModel.companyName ?? ''}', 
            style: rubikRegular.copyWith(fontSize: 25, fontWeight: FontWeight.w600, color: textColor ?? ColorResources.getNoteTextColor())),
      ],
    );
  }
}
