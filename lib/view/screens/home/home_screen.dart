
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/banner_controller.dart';
import 'package:six_cash/controller/home_controller.dart';
import 'package:six_cash/controller/notification_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/requested_money_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_history_controller.dart';
import 'package:six_cash/controller/websitelink_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/view/screens/home/widget/app_bar.dart';
import 'package:six_cash/view/screens/home/widget/bottom_sheet/expandable_contant.dart';
import 'package:six_cash/view/screens/home/widget/bottom_sheet/persistent_header.dart';
import 'package:six_cash/view/screens/home/widget/first_card_portion.dart';

import 'widget/linked_website_portion.dart';
import 'widget/shimmer/web_site_shimmer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _loadData(BuildContext context, bool reload) async {
    await Get.find<ProfileController>().profileData(loading: true).then((value) {
      if(value.isOk){
        Get.find<BannerController>().getBannerList(reload);
        Get.find<RequestedMoneyController>().getRequestedMoneyList(1,context ,reload: reload );
        Get.find<TransactionHistoryController>().getTransactionData(1, reload: reload);
        Get.find<WebsiteLinkController>().getWebsiteList();
        Get.find<NotificationController>().getNotificationList();
        if(reload) {
          Get.find<SplashController>().getConfigData();
        }
      }
    });



  }
  @override
  void initState() {
    _loadData(context, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<HomeController>(
        builder: (controller) {
          return Scaffold(
            backgroundColor: ColorResources.getBackgroundColor(),
            appBar: AppBarBase(),
            body: ExpandableBottomSheet(
                enableToggle: true,
                background: RefreshIndicator(
                  onRefresh: () async {
                    await _loadData(context, true);
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        GetBuilder<ProfileController>(builder: (profile)=> FirstCardPortion(profileController: profile)),
                        SizedBox(height: 10),

                        GetBuilder<WebsiteLinkController>(builder: (websiteLinkController){
                          return websiteLinkController.isLoading ?
                          WebSiteShimmer() : websiteLinkController.websiteList.length > 0 ?  LinkedWebsite() : SizedBox();
                        }),
                      ],
                    ),
                  ),
                ),
                persistentContentHeight: 70,
                persistentHeader: CustomPersistentHeader(),
                expandableContent: CustomExpandableContant()
            ),
          );
        });  }

}

