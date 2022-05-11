import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/controller/requested_money_controller.dart';
import 'package:six_cash/data/model/response/requested_money_model.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/no_data_screen.dart';
import 'package:six_cash/view/screens/requested_money/widget/requested_money_card.dart';
class RequestedMoneyScreen extends StatelessWidget {
  final ScrollController scrollController;
  final bool isHome;
  const RequestedMoneyScreen({Key key, this.scrollController, this.isHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels
          && Get.find<RequestedMoneyController>().requestedMoneyList.length != 0
          && !Get.find<RequestedMoneyController>().isLoading) {
        int pageSize;
        pageSize = Get.find<RequestedMoneyController>().pageSize;

        if(offset < pageSize) {
          offset++;
          print('end of the page');
          Get.find<RequestedMoneyController>().showBottomLoader();
          Get.find<RequestedMoneyController>().getRequestedMoneyList(offset, context);
        }
      }

    });
    return GetBuilder<RequestedMoneyController>(builder: (req){
      List<RequestedMoney> reqList;
      reqList = req.requestedMoneyList;
      if (Get.find<RequestedMoneyController>().requestTypeIndex == 0) {
        reqList = req.pendingRequestedMoneyList;
      } else if (Get.find<RequestedMoneyController>().requestTypeIndex == 1) {
        reqList = req.acceptedRequestedMoneyList;
      }  else if (Get.find<RequestedMoneyController>().requestTypeIndex == 2) {
        reqList = req.deniedRequestedMoneyList;
      }else{
        reqList = req.requestedMoneyList;
      }
      return Column(children: [
        !req.isLoading ? reqList.length != 0 ?
        Container(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: ListView.builder(
            physics:  NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:isHome?1: reqList.length,
              itemBuilder: (ctx,index){
                return Container(
                    child: RequestedMoneyCardWidget(requestedMoney: reqList[index], isHome: isHome));
              }),
        ): NoDataFoundScreen() : RequestedMoneyShimmer(isHome: isHome),


      ]);
    });
  }
}

class RequestedMoneyShimmer extends StatelessWidget {
  final bool isHome;
  const RequestedMoneyShimmer({Key key, this.isHome}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: isHome? 1 : Get.find<RequestedMoneyController>().requestedMoneyList.length,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          color: ColorResources.getGreyColor(),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[500],
            highlightColor: Colors.grey[100],
            enabled: Get.find<RequestedMoneyController>().requestedMoneyList == null,
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: ColorResources.whiteColor),
              subtitle: Container(height: 10, width: 50, color: ColorResources.whiteColor),
            ),
          ),
        );
      },
    );
  }
}