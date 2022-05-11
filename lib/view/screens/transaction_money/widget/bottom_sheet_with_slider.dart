import 'package:six_cash/controller/bootom_slider_controller.dart';
import 'package:six_cash/controller/screen_shot_widget_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/helper/TransactionType.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import 'avator_section.dart';

class BottomSheetWithSlider extends StatefulWidget {
  final String amount;
  final int amountCharge;
  final String pinCode;
  final String transactionType;
  // final String purpose;
  final ContactModel contactModel;
  const BottomSheetWithSlider({Key key, @required this.amount, @required this.amountCharge, this.pinCode, this.transactionType, this.contactModel}) : super(key: key);

  @override
  State<BottomSheetWithSlider> createState() => _BottomSheetWithSliderState();
}

class _BottomSheetWithSliderState extends State<BottomSheetWithSlider> {
  String transactionId ;

  @override
  void initState() {
    Get.find<TransactionMoneyController>().changeTrueFalse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String type = widget.transactionType == TransactionType.SEND_MONEY ? 'send_money'.tr
        : widget.transactionType == TransactionType.ADMIN_CASH_OUT ? 'admin_cash_out'.tr
        : widget.transactionType == TransactionType.ADD_MONEY ? 'add_money'.tr
        :'request_money'.tr;
    double cashOutCharge = double.parse(widget.amount.toString()) * (double.parse(Get.find<SplashController>().configModel.cashoutChargePercent.toString())/100);
    String customerImage = '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}/${widget.contactModel.avatarImage}';
    String companyImage = '${Get.find<SplashController>().configModel.baseUrls.companyImageUrl}/${Get.find<SplashController>().configModel.companyLogo}';
    return WillPopScope(
      onWillPop: ()=>Get.offAllNamed(RouteHelper.getNavBarRoute()),
      child: Container(
        decoration: BoxDecoration(
          color: ColorResources.getBackgroundColor(),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.RADIUS_SIZE_LARGE), topRight:Radius.circular(Dimensions.RADIUS_SIZE_LARGE) ),
        ),

        child: GetBuilder<TransactionMoneyController>(
          builder: (transactionMoneyController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE),
                      decoration: BoxDecoration(
                        color: ColorResources.getLightGray().withOpacity(0.8),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_SIZE_LARGE) ),
                      ),
                      child: Text('confirm_to'.tr +' '+ type, style: rubikSemiBold.copyWith(),),
                    ),
                    !transactionMoneyController.isLoading?
                    Visibility(
                      visible: !transactionMoneyController.isNextBottomSheet,
                      child: Positioned(
                        top: Dimensions.PADDING_SIZE_SMALL,
                        right: 8.0,
                        child: GestureDetector(onTap: ()=> Get.back(),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(shape: BoxShape.circle, color: ColorResources.getGreyBaseGray6()),
                                child: Icon(Icons.clear,size: Dimensions.PADDING_SIZE_DEFAULT,))),
                      ),
                    ) : SizedBox(),
                  ],
                ),

                transactionMoneyController.isNextBottomSheet?
                Column(
                  children: [
                    transactionMoneyController.isNextBottomSheet? Lottie.asset(Images.success_animation, width: Dimensions.SUCCESS_ANIMATION_WIDTH, fit: BoxFit.contain,alignment: Alignment.center ) : Padding(
                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL), child: Lottie.asset(Images.failed_animation, width: Dimensions.FAILED_ANIMATION_WIDTH,fit: BoxFit.contain,alignment: Alignment.center ),
                    ),
                  ],
                ): AvatarSection(image: widget.transactionType != TransactionType.ADMIN_CASH_OUT ? customerImage : companyImage),

                Container(
                  color: ColorResources.getBackgroundColor(),
                  child: Column(
                    children: [

                      transactionMoneyController.isNextBottomSheet ?
                      Text(widget.transactionType == TransactionType.SEND_MONEY? 'send_money_successful'.tr : widget.transactionType == TransactionType.REQUEST_MONEY ?'request_send_successful'.tr : 'cash_out_successful'.tr,
                          style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getPrimaryTextColor())):SizedBox(),

                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),

                      Text('${PriceConverter.balanceWithSymbol(balance: widget.amount)}', style: rubikMedium.copyWith(fontSize: 34.0)),
                      // SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      //
                      Text('new_balance'.tr+' '+'${widget.transactionType == TransactionType.REQUEST_MONEY ? PriceConverter.newBalanceWithCredit(inputBalance: double.parse(widget.amount))
                          : PriceConverter.newBalanceWithDebit(inputBalance: double.parse(widget.amount),
                          charge: 0)}',
                          style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),

                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Divider(height: Dimensions.DIVIDER_SIZE_SMALL)),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT,horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Column(
                          children: [
                           // Text(widget.transactionType != "cash_out"?  widget.purpose : 'cash_out'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),

                            widget.transactionType == TransactionType.ADMIN_CASH_OUT ? Text('cash_out_from_admin'.tr) : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.contactModel.name == null?'(unknown )' :'(${widget.contactModel.name}) ', style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                Text(widget.contactModel.phoneNumber, style: rubikSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                              ],
                            ),

                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                            transactionMoneyController.isNextBottomSheet ?
                            transactionId != null? Text( 'trx_id'.tr+': $transactionId', style: rubikLight.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)): SizedBox()
                            : SizedBox(),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),


                transactionMoneyController.isNextBottomSheet?
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT / 1.7),
                      child: Divider(height: Dimensions.DIVIDER_SIZE_SMALL),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomInkWell(
                        onTap:() async => await  Get.find<ScreenShootWidgetController>().statementScreenShootFunction(amount: widget.amount, transactionType: widget.transactionType, contactModel: widget.contactModel,
                            charge: widget.transactionType == TransactionType.SEND_MONEY ? '0' :  cashOutCharge.toString(), trxId: transactionId ),
                        child: Text('share_statement'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE))),

                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  ],
                ) : SizedBox(),



                transactionMoneyController.isNextBottomSheet?
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorResources.getSecondaryHeaderColor(),
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
                    ),
                    child: CustomInkWell(
                      onTap: (){
                        Get.find<BottomSliderController>().goBackButton();
                      },
                      radius: Dimensions.RADIUS_SIZE_SMALL,
                      highlightColor: ColorResources.getPrimaryTextColor().withOpacity(0.1),
                      child: SizedBox(
                        height: 50.0,
                        child: Center(child: Text('back_to_home'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),)),

                      ),
                    ),
                  ),
                ):
                transactionMoneyController.isLoading ? Center(child: CircularProgressIndicator(color: ColorResources.getPrimaryTextColor(),))
                    : ConfirmationSlider(
                        height: 60.0,
                        backgroundColor: ColorResources.getGreyBaseGray6(),
                        text: 'swipe_to_confirm'.tr,
                        textStyle: rubikRegular.copyWith(fontSize: Dimensions.PADDING_SIZE_LARGE),
                        shadow: BoxShadow(),
                        sliderButtonContent: Container(
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                          decoration: BoxDecoration(
                            color: ColorResources.getSecondaryHeaderColor(),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(Images.slide_right_icon),

                        ),
                        onConfirmation: ()async{
                          if( widget.transactionType == TransactionType.SEND_MONEY){
                            transactionMoneyController.cashIn(contactModel: widget.contactModel, amount: double.parse(widget.amount), pinCode: widget.pinCode).then((value) {
                              transactionId = value.body['transaction_id'];
                            });
                          }else if(widget.transactionType == TransactionType.ADMIN_CASH_OUT){
                            transactionMoneyController.cashOutMoney(amount: double.parse(widget.amount),pinCode: widget.pinCode).then((value) {
                              transactionId = value.body['transaction_id'];
                            });
                          }

                       },

                ),
                SizedBox(height: 40.0),

              ],
            );
          }
        ),
      ),
    );
  }
}