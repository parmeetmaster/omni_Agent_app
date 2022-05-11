import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/controller/transaction_history_controller.dart';
import 'package:six_cash/data/model/transaction_model.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';

class RoundedTextSelectionButton extends StatelessWidget {
  final String text;
  final int index;
  final bool fromBalanceInput;
  final List<Transactions> transactionHistoryList;
  final Function callBack;

  RoundedTextSelectionButton({@required this.text, @required this.index, this.transactionHistoryList, this.fromBalanceInput = false, this.callBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: fromBalanceInput && Get.find<TransactionMoneyController>().selectAmount != null ?
            index == Get.find<TransactionMoneyController>().selectAmount ? ColorResources.getSecondaryHeaderColor() :
            Theme.of(context).cardColor : Get.find<TransactionHistoryController>().transactionTypeIndex == index ?
            ColorResources.getSecondaryHeaderColor() :  Theme.of(context).cardColor,

          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_LARGE),
          border: Border.all(width: .5,color: ColorResources.getGreyColor())
      ),
      child: CustomInkWell(
        onTap: fromBalanceInput ? callBack : () =>Get.find<TransactionHistoryController>().setIndex(index),
        radius: Dimensions.RADIUS_SIZE_LARGE,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Text(text,
              style: rubikRegular.copyWith(fontSize: fromBalanceInput ? Dimensions.FONT_SIZE_LARGE :  Dimensions.FONT_SIZE_DEFAULT,
                  )),
        ),
      ),
    );
  }
}