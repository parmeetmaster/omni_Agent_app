
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/view/screens/home/widget/banner_view.dart';
import 'package:six_cash/view/screens/home/widget/custom_card3.dart';

class ThirdCardPortion extends StatelessWidget {
  const ThirdCardPortion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return SizedBox(
      child: Stack(
        children: [
          Container(height: Dimensions.THIRD_CARD_HEIGHT, color: ColorResources.getPrimaryColor()),
          Positioned(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE,bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  child: Row(
                    children: [
                     Expanded(child: CustomCard3(image: Images.sendMoneyLogo3, text: 'send_money'.tr, height: 38, width: 38,
                            onTap: () {
                             // Get.offAll(()=> TransactionMoneyBalanceInput(transactionType: AppConstants.AGENT_CASH_OUT));
                            },
                          ),
                        ),
                        Expanded(child: CustomCard3(image: Images.cashOutLogo3, text: 'cash_out'.tr, height: 37, width: 37,
                            onTap: () {
                           //   Get.offAll(()=> TransactionMoneyScreen(fromEdit: false,transactionType: 'cash_out'));
                            },
                          ),
                        ),
                         Expanded(child: CustomCard3(image: Images.addMoneyLogo3, text: 'Add Money'.tr, height: 35, width: 30,
                            onTap: () {
                              Get.toNamed(RouteHelper.getAddMoneyInputRoute());
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                // const SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                    Expanded(child: CustomCard3(image: Images.request_money_image, text: 'request_money'.tr, height: 32, width: 48,
                            onTap: () {
                            //  Get.offAll(()=> TransactionMoneyScreen(fromEdit: false,transactionType: 'request_money'));
                            },
                          ),
                        ),
                        Expanded(child: CustomCard3(image: Images.referLogo3, text: 'refer_friend'.tr, height: 35.5, width: 37,
                            onTap: () {
                              Share.share(profileController.userInfo.uniqueId);
                            },
                          ),
                        ),
                        Expanded(child: CustomCard3(image: Images.paymentLogo3, text: 'make_payment'.tr, height: 27, width: 27,
                            onTap: () {},
                          ),
                        ),
                    ],
                  ),
                ),
                /// Banner..
                BannerView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
