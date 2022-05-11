/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/home_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/images.dart';
class ThemeAndLanguage extends StatelessWidget {
  const ThemeAndLanguage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller){
          return Scaffold(
            body: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.find<HomeController>().itemSelect(index: 0);
                        },
                        child: Stack(
                          children: [
                            Container(height: 200, width: 90, color: Colors.amber,
                              child: Image.asset(Images.homePage1, fit: BoxFit.cover)),
                            Visibility(
                              visible: controller.selectedItem==0 ? true : false,
                              child: Positioned(top: 10, right: 10,
                                child: Container(height: 20, width: 20, color: ColorResources.getPrimaryColor(),
                                  child: Icon(Icons.done,color: Colors.white,),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.find<HomeController>().itemSelect(index: 1);
                        },
                        child: Stack(
                          children: [
                            Container(height: 200, width: 90, color: Colors.amber,
                              child: Image.asset(
                                Images.homePage2,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Visibility(
                              visible: controller.selectedItem == 1 ? true : false,
                              child: Positioned(top: 10, right: 10,
                                child: Container(height: 20, width: 20, color: ColorResources.getPrimaryColor(),
                                  child: Icon(Icons.done,color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.find<HomeController>().itemSelect(index: 2);
                        },
                        child: Stack(
                          children: [
                            Container(height: 200, width: 90, color: Colors.amber,
                              child: Image.asset(Images.homePage3, fit: BoxFit.cover,),
                            ),
                            Visibility(
                              visible: controller.selectedItem == 2 ? true : false,
                              child: Positioned(top: 10, right: 10,
                                child: Container(height: 20, width: 20, color: ColorResources.getPrimaryColor(),
                                  child: Icon(Icons.done,color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text('home'.tr),
                */
/*TextButton(
                  onPressed: () => Get.find<ThemeController>().toggleTheme(),
                  child: Text('Toggle theme'),
                ),
                TextButton(
                  onPressed: () {
                    Get.find<LocalizationController>().setLanguage(Locale(Get.locale.languageCode == 'en' ? 'ar' : 'en', Get.locale.countryCode == 'US' ? 'SA' : 'US',));
                  },
                  child: Text('Change Localization'),
                ),*//*

              ]),
            ),
          );
        });
  }
}
*/
