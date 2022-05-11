
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
class AppbarHomeElement extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppbarHomeElement({@required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.getPrimaryColor(),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //SizedBox(height: 74.0),

          Text(title, style: rubikSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,color: ColorResources.whiteColor),),
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,)
        ],
      ),
      
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 60.0);
}