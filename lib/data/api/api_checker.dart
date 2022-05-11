import 'package:get/get.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/data/model/response/error_response.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<AuthController>().removeCustomerToken();
      Get.offAllNamed(RouteHelper.getLoginRoute(countryCode: Get.find<AuthController>().getCustomerCountryCode(),phoneNumber: Get.find<AuthController>().getUserNumber()));

      showCustomSnackBar(response.statusText, isIcon: true);

    } else if(response.statusCode == 400) {
      showCustomSnackBar('to_money_login_attempts'.tr);

    }
    else {
      showCustomSnackBar(response.body['message'] ?? ErrorResponse.fromJson(response.body).errors.first.message, isError: true);
    }
  }
}