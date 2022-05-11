import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/custom_pin_code_field.dart';
class OtpFieldSectiion extends StatefulWidget {
  final String phoneNumber;
  const OtpFieldSectiion({Key key,@required this.phoneNumber}) : super(key: key);

  @override
  _OtpFieldSectiionState createState() => _OtpFieldSectiionState();
}

class _OtpFieldSectiionState extends State<OtpFieldSectiion> {
  @override
  Widget build(BuildContext context) {
    return CustomPinCodeField(
      padding: Dimensions.PADDING_SIZE_OVER_LARGE,
      onCompleted: (pin){
        print("Completed: " + pin);
        Get.find<ForgetPassController>().setOtp(pin);
        String _phoneNumber = widget.phoneNumber;
        print("phone number : $_phoneNumber");
        Get.find<AuthController>().verificationForForgetPass(_phoneNumber, pin, context);
      },
    );
  }
}
