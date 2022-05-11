import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:six_cash/controller/varification_controller.dart';
import 'package:six_cash/view/base/custom_pin_code_field.dart';

class OtpField extends StatelessWidget {
  final Function otpOnCompleted;
  const OtpField({Key key, @required this.otpOnCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VarificationController>(builder: (getController){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPinCodeField(onCompleted: otpOnCompleted),

          // GetBuilder<CashOutController>(
          //   builder: (cashOutController) {
          //     return GetBuilder<TransactionMoneyController>(
          //       builder: (sendMoneyController) {
          //         return GetBuilder<RequestMoneyController>(
          //           builder: (requestMoneyController) {
          //             return (sendMoneyController.isOtpFieldLoading || requestMoneyController.isOtpFieldLoading || cashOutController.isOtpFieldLoading) ? Padding( padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          //               child: CircularProgressIndicator(color: ColorResources.getPrimaryTextColor(),)) : SizedBox();
          //           }
          //         );
          //       }
          //     );
          //   }
          // ),
        ],
      );
    });
  }
}
