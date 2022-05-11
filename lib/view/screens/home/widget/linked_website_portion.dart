import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/websitelink_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/screens/add_money/widget/web_screen.dart';

class LinkedWebsite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebsiteLinkController>(builder: (websiteLinkController){
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Text('linked_website'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getPrimaryTextColor(),),),),


              Container(height: 86,
                width: double.infinity,
                margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [
                  BoxShadow(color: ColorResources.containerShedow.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 3),)]),
                child: ListView.builder(
                  itemCount: websiteLinkController.websiteList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CustomInkWell(
                      onTap: () => Get.to(WebScreen(fromLinkClick: true, url: websiteLinkController.websiteList[index].url)),
                      radius: Dimensions.RADIUS_SIZE_EXTRA_SMALL,
                      highlightColor: ColorResources.getPrimaryColor().withOpacity(0.1),
                      child: Container(width: 100,
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Column(
                          children: [
                            SizedBox(width: 50, height: 30,
                              child: FadeInImage.assetNetwork(
                                image: "${Get.find<SplashController>().configModel.baseUrls.linkedWebsiteImageUrl}/${websiteLinkController.websiteList[index].image}",
                                placeholder: Images.web_link_place_holder, fit: BoxFit.fitWidth,
                                imageErrorBuilder: (context, url, error) => Image.asset(Images.placeholder, fit: BoxFit.fitWidth),
                              ),
                            ),

                            const Spacer(),
                            Text(websiteLinkController.websiteList[index].name, style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getWebsiteTextColor(),),),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL ,
              ),
            ],
          ),
        );
      }
    );
  }
}
