import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';

class CustomGenderCard extends StatelessWidget {
  final String icon, text;
  final Color color;
  final Function onTap;
  CustomGenderCard({this.icon, this.text, this.color,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 76,
        width: 94,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(icon),
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            Text(
              text,
              style: rubikRegular.copyWith(
                color: ColorResources.getBlackColor(),
                fontSize: Dimensions.FONT_SIZE_DEFAULT,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
