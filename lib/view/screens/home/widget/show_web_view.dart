import 'package:six_cash/controller/home_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ShowWebViewScreen extends StatelessWidget {
  const ShowWebViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.getPrimaryColor(),
        title: Text(Get.find<HomeController>().webSiteLink),),
      body: WebView(
        initialUrl: Get.find<HomeController>().webSiteLink,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    ));
  }
}
