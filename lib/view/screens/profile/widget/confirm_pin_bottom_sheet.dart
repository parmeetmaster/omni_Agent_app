
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:six_cash/controller/bootom_slider_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/transaction_money/widget/next_button.dart';

class ConfirmPinBottomSheet extends StatelessWidget {
  ConfirmPinBottomSheet({Key key}) : super(key: key);
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
            child: Container(
              // padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              //padding: EdgeInsets.symmetric(horizontal: 10.0),
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27.0),
                  color: ColorResources.getGreyBaseGray6()
              ),

              child:PinCodeTextField(
                controller: _textEditingController,
                length: 4, appContext:  context, onChanged: (value){
                Get.find<BottomSliderController>().changePinComleted(value);
              },
                //backgroundColor: ColorResources.getGreyBaseGray6(),
                keyboardType: TextInputType.number, inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                obscureText: true, hintCharacter: '•', hintStyle: rubikMedium.copyWith(color: ColorResources.getGreyBaseGray4()),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                cursorColor: ColorResources.getGreyBaseGray6(),

                pinTheme: PinTheme.defaults(
                  shape: PinCodeFieldShape.circle,
                  activeColor: ColorResources.getGreyBaseGray6(),
                  activeFillColor: Colors.red,selectedColor: ColorResources.getGreyBaseGray6(),
                  borderWidth: 0,

                  inactiveColor: ColorResources.getGreyBaseGray6(),
                  //fieldHeight: 20.0
                ),

              ),

            ),
          ),
        ),
        //SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
        InkWell(
            onTap: () {
              if(Get.find<BottomSliderController>().isPinCompleted) {
                Get.find<ProfileController>().twoFactorOnTap();
              }else {
                Get.find<BottomSliderController>().changePinComleted('');
                Get.back(closeOverlays: true);
                showCustomSnackBar('please_input_4_digit_pin'.tr);
              }
            },

            child: GetBuilder<BottomSliderController>(
                builder: (controller) {
                  return controller.isLoading? Center(child: CircularProgressIndicator(color: ColorResources.getPrimaryTextColor(),)): NextButton(isSubmittable: controller.isPinCompleted);
                }
            )
        )
      ],
    );
  }
}
