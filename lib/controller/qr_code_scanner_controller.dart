import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class QrCodeScannerController extends GetxController implements GetxService{

  String _name;
  String _phone;
  String _type;
  String _image;

  String get name => _name;
  String get phone => _phone;
  String get type => _type;
  String get image => _image;
  String _transactionType;
  String get transactionType => _transactionType;



  Future<String> scanQR() async{
      String scannedQrcode = await FlutterBarcodeScanner.scanBarcode('#003E47', 'cancel', false, ScanMode.QR);
      if(scannedQrcode != "-1") {
        var a = jsonDecode(scannedQrcode);
        _name = a['name'];
        _phone = a['phone'];
        _type = a['type'];
        _image = a['image'];


        // if(_type =="customer"){
        //   _transactionType = "send_money";
        // }else if(_type =="agent"){
        //   _transactionType = "cash_out";
        // }


        //actionFunction();
      }
      return _phone;
  }
}