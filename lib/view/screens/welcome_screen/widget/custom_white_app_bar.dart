import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
class CustomWhiteAppbar extends StatelessWidget implements PreferredSizeWidget {

  final Function onTap;
  const CustomWhiteAppbar({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.getWhiteColor(),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
      child: Padding(
        padding: const EdgeInsets.only(top:Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE, bottom: Dimensions.PADDING_SIZE_LARGE),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                height: 40.0, width: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorResources.INNER_BORDER_COLOR,width: 0.5),
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
                ),
                child: Icon(Icons.arrow_back_ios_new,size: 12.0, color: ColorResources.getPrimaryColor(),),
              ),
            ),
            // Text(title,style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: ColorResources.COLOR_WHITE) ,),
            Container(
              height: 24.0, width: 62.0, alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_LARGE), color: ColorResources.getSecondaryHeaderColor(),
              ),
              child: Text('language'.tr,style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.COLOR_BLACK)),),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, Dimensions.APPBAR_HEIGHT_SIZE);
}