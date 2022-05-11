import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/data/model/response/requested_money_model.dart';
import 'package:six_cash/helper/date_converter.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

class RequestedMoneyCardWidget extends StatefulWidget {
  final RequestedMoney requestedMoney;
  final bool isHome;
  const RequestedMoneyCardWidget({Key key, this.requestedMoney, this.isHome}) : super(key: key);

  @override
  State<RequestedMoneyCardWidget> createState() => _RequestedMoneyCardWidgetState();
}

class _RequestedMoneyCardWidgetState extends State<RequestedMoneyCardWidget> {
  final TextEditingController reqPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.requestedMoney.receiver.name}', style: rubikMedium.copyWith(color: ColorResources.getTextColor(),fontSize: Dimensions.FONT_SIZE_LARGE) ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SUPER_EXTRA_SMALL),

                    Text('amount_'.tr + '${PriceConverter.balanceWithSymbol(
                        balance: widget.requestedMoney.amount.toString())}',
                        style: rubikMedium.copyWith(color: ColorResources.getPrimaryTextColor(),fontSize: Dimensions.FONT_SIZE_DEFAULT)
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    Text(DateConverter.localDateToIsoStringAMPM(
                        DateTime.parse(widget.requestedMoney.createdAt)),
                        style: rubikLight.copyWith(color: ColorResources.getTextColor(), fontSize: Dimensions.FONT_SIZE_SMALL)
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              ]),
            ],
          ),
          SizedBox(height: 5),
          widget.isHome ? SizedBox() : Divider(height: .5,color: ColorResources.getGreyColor()),
        ],
      ),
    );
  }
}
