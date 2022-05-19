import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/splash_controller.dart';
class CustomCountryCodePiker extends StatelessWidget {
  final Function(CountryCode) onChanged;
  final String initSelect;
  const CustomCountryCodePiker({@required this.onChanged, this.initSelect});

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      dialogBackgroundColor: Theme.of(context).canvasColor,
      onChanged: onChanged,
      showDropDownButton: true,
      padding: EdgeInsets.zero,
      initialSelection: initSelect ?? Get.find<SplashController>().configModel.country,
      favorite: ['+971','+880'],
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
      showFlag: false,
    );
  }
}
