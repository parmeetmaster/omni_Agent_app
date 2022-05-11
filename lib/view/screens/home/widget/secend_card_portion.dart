
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/home/widget/banner_view.dart';
import 'package:six_cash/view/screens/home/widget/custom_card.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';

class SecondCardPortion extends StatelessWidget {
  const SecondCardPortion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return SizedBox(
      child: Stack(
        children: [
          Container(
            height: 75,
            color: ColorResources.getPrimaryColor(),
          ),
          Positioned(
            child: Column(
              children: [
                
                Container(
                  width: double.infinity,
                  height: 100,
                  margin: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE),
                 padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: Row(
                    children: [
                     Expanded(
                          child: CustomCard(
                            image: Images.sendMoney_logo,
                            text: 'send_money'.tr,
                            color: ColorResources.getSecondaryHeaderColor(),
                            onTap: () {
                              Get.offAll(()=> TransactionMoneyBalanceInput(transactionType: AppConstants.CASH_IN));
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomCard(
                            image: Images.cashOut_logo,
                            text: 'cash_out'.tr,
                            color: ColorResources.getCashOutCardColor(),
                            onTap: () {
                              Get.offAll(()=> TransactionMoneyBalanceInput(transactionType: AppConstants.AGENT_CASH_OUT));
                            },
                          ),
                        ),
                         Expanded(
                          child: CustomCard(
                            image: Images.wolet_logo,
                            text: 'Add Money'.tr,
                            color: ColorResources.getAddMoneyCardColor(),
                            onTap: () {
                              Get.toNamed(RouteHelper.getAddMoneyInputRoute());
                            },
                          ),
                        ),
                        
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                 padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: Row(
                    children: [
                    Expanded(
                          child: CustomCard(
                            image: Images.requestMoney_logo,
                            text: 'request_money'.tr,
                            color: ColorResources.getRequestMoneyCardColor(),
                            onTap: () {
                              Get.offAll(()=> TransactionMoneyBalanceInput(transactionType: AppConstants.AGENT_REQUEST_MONEY));
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomCard(
                            image: Images.admin_cashOut_logo,
                            text: 'refer_friend'.tr,
                            color: ColorResources.getReferFriendCardColor(),
                            onTap: () {
                              Share.share(profileController.userInfo.uniqueId);
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomCard(
                            image: Images.otherLogo,
                            text: 'others'.tr,
                            color: ColorResources.getOthersCardColor(),
                            onTap: () {
                              showCustomSnackBar('this_feature_will_added_soon'.tr,isError: false);
                            },
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
