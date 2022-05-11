import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onTap;
  const CustomAppbar({@required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.getPrimaryColor(),
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomInkWell(
              onTap: onTap == null ? () {
                Get.back();
              } : onTap,
              radius: Dimensions.RADIUS_SIZE_SMALL,
              child: Container(
                height: 40,width: 40,
                // padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorResources.INNER_BORDER_COLOR, width: 0.5),
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
                ),
                child: Center(
                  child: Icon(Icons.arrow_back_ios_new, size: Dimensions.ARROW_ICON_SIZE, color: ColorResources.COLOR_WHITE,
                  ),
                ),
              ),
            ),
            Text(title, style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: ColorResources.COLOR_WHITE),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, Dimensions.APPBAR_HEIGHT_SIZE);
}
