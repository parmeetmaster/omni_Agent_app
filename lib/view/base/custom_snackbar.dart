
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, {bool isError = true, bool isIcon = false}) {

 if(message != null && message.isNotEmpty){
  Get..closeCurrentSnackbar()..showSnackbar(GetSnackBar(
     message: message,
     snackStyle: SnackStyle.FLOATING,
      duration: Duration(seconds: 5),
     isDismissible: true,
     backgroundColor: isError ? Colors.red : Colors.green,
   icon: isIcon ?  IconButton(icon: Icon(Icons.clear,size: 16,),color: Colors.white,
      onPressed: (){
       Get.back();
      }) : null,
   ));


 }
}