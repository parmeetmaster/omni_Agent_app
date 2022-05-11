
import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/image_controller.dart';
import 'package:six_cash/main.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/animated_custom_dialog.dart';
import 'package:six_cash/view/base/my_dialog.dart';
import 'package:six_cash/view/screens/auth/selfie_capture/widget/selfie_app_bar.dart';
import 'package:six_cash/view/screens/auth/selfie_capture/widget/text_section.dart';

class SelfieCaptureScreen extends StatefulWidget {
  final bool fromEditProfile;
  SelfieCaptureScreen({Key key,@required this.fromEditProfile}) : super(key: key);

  @override
  State<SelfieCaptureScreen> createState() => _SelfieCaptureScreenState();
}

class _SelfieCaptureScreenState extends State<SelfieCaptureScreen> {
  CameraController controller;
  XFile imageFile;


  @override
  void initState() {
    super.initState();

    controller = CameraController(cameras[1], ResolutionPreset.medium, enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return ;
      }
      setState(() {});
    });



  }

  @override
  Widget build(BuildContext context) {
    var tmp = MediaQuery.of(context).size;
    tmp = controller.value.previewSize;



    if (!controller.value.isInitialized) {
      return Scaffold(
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }


    return WillPopScope(
      onWillPop: (){
        return  _onWillPop(context);

      },
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: SelfieAppbar(
          fromEditProfile: widget.fromEditProfile,
          showIcon: imageFile == null ? false : true,
          onTap: () {
            imageFile = null;
            setState(() {

            });
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT),

          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: tmp.width * 0.6  ,width: tmp.width * 0.6,
                decoration: BoxDecoration(shape: BoxShape.circle,),
                child: imageFile == null ? ClipRRect(
                  borderRadius: BorderRadius.circular(tmp.width * 0.6),
                  child: OverflowBox(
                    child: CameraPreview(
                      controller,
                    ),
                  ),
                ) :
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(tmp.width * 0.6),
                    child: Image.file(
                      File(imageFile.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              TextSection()
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: ColorResources.getPrimaryColor(),
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
          child: Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorResources.getWhiteColor(),
                width: 4,
              ),
            ),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).cardColor,
              elevation: 0,
              onPressed: () async {
                if(imageFile == null){
                  imageFile = await controller.takePicture();
                  print(File(imageFile.path));
                  print(imageFile.path);
                  Get.find<ImageController>().setImage(File(imageFile.path));
                  setState(() {});
                }


              },
            ),
          ),
        ),
      ),
    );
  }
  Future _onWillPop(BuildContext context) async {
    if(widget.fromEditProfile == false){
      showAnimatedDialog(context,
          MyDialog(
            icon: Icons.clear,
            title: 'alert'.tr,
            description: 'your_information_will_remove'.tr,
            isFailed: true,
            showTwoBtn: true,
          ),
          dismissible: false,
          isFlip: true);

    }
    else{
      return Get.back();
    }
  }

}
