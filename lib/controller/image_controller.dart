import 'dart:io';
import 'package:get/get.dart';
class ImageController extends GetxController implements GetxService{

  File _imageFile;
  File get getImage => _imageFile;
  void setImage(File image){
    _imageFile = image;
    update();
  }
  void removeImage(){
    _imageFile = null;
    update();
  }
  
}