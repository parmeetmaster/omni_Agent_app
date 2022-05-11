import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/helper/TransactionType.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/view/screens/home/widget/banner_view.dart';
import 'package:six_cash/view/screens/home/widget/custom_card.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';

class FirstCardPortion extends StatelessWidget {
  final ProfileController profileController;
  const FirstCardPortion({Key key,@required this.profileController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: Dimensions.MAIN_BACKGROUND_CARD_WEIGHT, color: ColorResources.getPrimaryColor(),),
        Positioned(
          child: Column(
            children: [
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
              SizedBox(
                height: Dimensions.TRANSACTION_TYPE_CARD_HEIGHT,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.FONT_SIZE_EXTRA_SMALL),
                  child: Row(
                    children: [
                      // Expanded(child: CustomCard(image: Images.sendMoney_logo, text: 'cash_in'.tr, color: ColorResources.getSecondaryHeaderColor(), onTap: ()=> Get.offAll(()=> TransactionMoneyBalanceInput()))),
                      Expanded(child: CustomCard(image: Images.sendMoney_logo, text: 'send_money_'.tr, color: ColorResources.getSecondaryHeaderColor(), onTap: ()=> Get.to(()=> TransactionMoneyBalanceInput(transactionType: TransactionType.SEND_MONEY)))),
                      Expanded(child: CustomCard(image: Images.addMoneyLogo3, text: 'add_money_'.tr, color: ColorResources.getCashOutCardColor(), onTap: ()=> Get.to(TransactionMoneyBalanceInput(transactionType: TransactionType.ADD_MONEY)))),
                      Expanded(child: CustomCard(image: Images.requestMoneyLogo, text: 'request_money_'.tr, color: ColorResources.getRequestMoneyCardColor(), onTap: ()=> Get.to(()=> TransactionMoneyBalanceInput(transactionType: TransactionType.REQUEST_MONEY)))),
                      Expanded(child: CustomCard(image: Images.admin_cashOut_logo, text: 'cash_out_'.tr, color: ColorResources.getReferFriendCardColor(), onTap: () => Get.to(()=> TransactionMoneyBalanceInput(transactionType: TransactionType.ADMIN_CASH_OUT)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Banner..
              BannerView(),

            ],
          ),
        ),
      ],
    );
  }

}
