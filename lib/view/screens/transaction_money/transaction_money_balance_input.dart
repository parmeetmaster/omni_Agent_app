import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/add_money_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/qr_code_scanner_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/helper/TransactionType.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_country_code_picker.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/base/input_field_shimmer.dart';
import 'package:six_cash/view/base/rounded_text_selection_button.dart';
import 'package:six_cash/view/screens/transaction_money/widget/transaction_money_confirmation.dart';

import 'widget/next_button.dart';
import 'widget/scan_button.dart';

class TransactionMoneyBalanceInput extends StatefulWidget {
  final String transactionType;
   TransactionMoneyBalanceInput({Key key, this.transactionType}) : super(key: key);
  @override
  State<TransactionMoneyBalanceInput> createState() => _TransactionMoneyBalanceInputState();
}

class _TransactionMoneyBalanceInputState extends State<TransactionMoneyBalanceInput> {
  final TextEditingController _inputAmountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final qrScannerController = Get.find<QrCodeScannerController>();
  final splashController = Get.find<SplashController>();

  void setInputValue(String amount) {
    _inputAmountController.text = splashController.configModel.currencyPosition == 'left' ? '${splashController.configModel.currencySymbol}$amount' : '$amount${splashController.configModel.currencySymbol}' ;
    Get.find<TransactionMoneyController>().selectAmountSet(Get.find<TransactionMoneyController>().inputAmountList.indexOf(amount));
  }
  String _countryCode = '+880';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<TransactionMoneyController>().selectAmountSet(Get.find<TransactionMoneyController>().inputAmountList.indexOf(AppConstants.inputAmountList.first));
  }
  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final transactionMoneyController = Get.find<TransactionMoneyController>();

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: CustomAppbar(title: widget.transactionType == TransactionType.SEND_MONEY ? 'send_money'.tr
          : widget.transactionType == TransactionType.ADMIN_CASH_OUT ? 'cash_out_from_admin'.tr
          : widget.transactionType == TransactionType.ADD_MONEY ? 'add_money'.tr : 'request_money_to_admin'.tr),
          body: SingleChildScrollView(
            child: Column(
              children: [
               widget.transactionType == TransactionType.SEND_MONEY ? Column(children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT), color: ColorResources.getGreyBaseGray3(),
                    child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                                      hintText: 'customer_mobile_number'.tr,
                                      hintStyle: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getGreyBaseGray1()),
                                      prefixIcon: CustomCountryCodePiker(
                                        onChanged: (code) => _countryCode = code,
                                      ),
                                  ))),
                          Icon(Icons.search, color: ColorResources.getGreyBaseGray1()),
                        ]),
                  ),
                  Divider(height: Dimensions.DIVIDER_SIZE_SMALL, color: Theme.of(context).dividerColor),

                  Container(
                    color: Theme.of(context).cardColor,
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScanButton(onTap: () async => await  qrScannerController.scanQR().then((value) => _phoneController.text =  value.replaceAll(_countryCode, '') )),

                        ],
                      ),
                    ),
                  ),
                  Container(height: Dimensions.DIVIDER_SIZE_MEDIUM, color: Theme.of(context).dividerColor),

                ],
                ) : SizedBox(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  // widget.transactionType !=  TransactionType.ADD_MONEY ? ForPersonWidget(contactModel: widget.contactModel) : SizedBox.shrink(),
                    GetBuilder<TransactionMoneyController>(
                      builder: (controller) {
                        return controller.isLoading ? widget.transactionType == TransactionType.ADMIN_CASH_OUT && widget.transactionType != TransactionType.ADD_MONEY ? SizedBox() : InputFieldShimmer() : Column(
                          children: [ Stack(
                              children: [
                                Container(color: Theme.of(context).cardColor,
                                  child: Column(
                                    children: [ Container( width: size.width * 0.6,
                                        padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE),
                                        child: TextField(
                                          inputFormatters: <TextInputFormatter>[
                                            LengthLimitingTextInputFormatter(8),
                                            CurrencyTextInputFormatter(
                                              decimalDigits: 0,
                                              locale: Get.find<SplashController>().configModel.currencyPosition == 'left' ? 'en' : 'fr',
                                              symbol:'${Get.find<SplashController>().configModel.currencySymbol}',
                                            )
                                          ],
                                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                                          controller: _inputAmountController,
                                          textAlignVertical: TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          style: rubikMedium.copyWith(fontSize: 34, color: ColorResources.getPrimaryTextColor()),
                                          decoration: InputDecoration(
                                              isCollapsed : true,
                                              hintText:'${PriceConverter.balanceInputHint()}',
                                              border : InputBorder.none, focusedBorder: UnderlineInputBorder(),
                                              hintStyle: rubikMedium.copyWith(fontSize: 34, color: ColorResources.getPrimaryTextColor().withOpacity(0.7)),

                                          ),

                                        ),
                                      ),
                                      Center( child: GetBuilder<ProfileController>( builder: (profController) {
                                            return profController.isLoading ? Center(child: CircularProgressIndicator(color: ColorResources.getPrimaryTextColor())) :
                                            Text('${'available_balance'.tr} ${PriceConverter.availableBalance()}',
                                                style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getGreyColor())
                                            );
                                          }
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),


                                    ],
                                  ),
                                ),

                              ],
                            ),

                            Container(height: Dimensions.DIVIDER_SIZE_MEDIUM, color: Theme.of(context).dividerColor,),

                          ],
                        );
                      }
                    ),


                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: transactionMoneyController.inputAmountList.map((amount) =>
                          GetBuilder<TransactionMoneyController>( id: 'inputAmountListController',
                            builder: (inputAmountListController) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RoundedTextSelectionButton(
                                  index: inputAmountListController.inputAmountList.indexOf(amount),
                                  text: amount.toString(), callBack: () {setInputValue(amount); },
                                  fromBalanceInput: true
                                ),
                              );
                            }
                          )).toList()),
                    )


                  ],
                ),
              ],
            ),
          ),
      
          floatingActionButton: GetBuilder<TransactionMoneyController>(
            builder: (controller) {

              return  FloatingActionButton(
                onPressed:() {
                  String _phoneNumber = '$_countryCode${_phoneController.text}';
                  double amount;
                  if(_inputAmountController.text.isEmpty){
                    showCustomSnackBar('please_input_amount'.tr,isError: true);
                  }else{
                    String balance =  _inputAmountController.text;
                    balance = balance.replaceAll('${splashController.configModel.currencySymbol}', '');
                    if(balance.contains(',')){
                      balance = balance.replaceAll(',', '');
                    }
                    if(balance.contains(' ')){
                      balance = balance.replaceAll(' ', '');
                    }

                     amount = double.parse(balance);
                    if(amount == 0) {
                      showCustomSnackBar('transaction_amount_must_be'.tr);
                    }else {
                      if(widget.transactionType != TransactionType.REQUEST_MONEY && amount >= profileController.userInfo.balance && widget.transactionType != TransactionType.ADD_MONEY) {
                        showCustomSnackBar('insufficient_balance'.tr, isError: true);

                      }else if(widget.transactionType == TransactionType.ADD_MONEY){
                        Get.find<AddMoneyController>().addMoney(context, amount.toString());
                      }else if(widget.transactionType == TransactionType.REQUEST_MONEY){
                        transactionMoneyController.requestMoney(amount: amount);
                      }
                      else if(widget.transactionType == TransactionType.SEND_MONEY){
                        transactionMoneyController.checkCustomerNumber(phoneNumber: _phoneNumber).then((value) {
                          if (value.isOk) {
                            String _customerName = value.body['data']['name'];
                            String _customerImage = value.body['data']['image'];
                            Get.to(() => TransactionMoneyConfirmation(inputBalance: amount, transactionType: widget.transactionType,
                                contactModel: ContactModel(phoneNumber: _phoneNumber , name: _customerName, avatarImage: _customerImage)));
                          }
                        });
                      }else if(widget.transactionType == TransactionType.ADMIN_CASH_OUT) {
                        Get.to(() => TransactionMoneyConfirmation(inputBalance: amount, transactionType: widget.transactionType,
                            contactModel: ContactModel(phoneNumber: _phoneNumber)));

                      }
                    }
                  }
                },
                child: GetBuilder<TransactionMoneyController>(
                  id: 'inout_screen_button_id',
                  builder: (transactionController) {
                    return transactionMoneyController.isLoading ? CircularProgressIndicator() : NextButton(isSubmittable: true);
                  }
                ),
                backgroundColor: ColorResources.getSecondaryHeaderColor(),
              );
            }
          )
        
        ),
      ),
      
    );
  }
}




