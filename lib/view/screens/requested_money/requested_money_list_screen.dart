import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/requested_money_controller.dart';
import 'package:six_cash/data/model/response/requested_money_model.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_loader.dart';
import 'package:six_cash/view/screens/requested_money/widget/requested_money_screen.dart';
class RequestedMoneyListScreen extends StatefulWidget {

  RequestedMoneyListScreen({Key key}) : super(key: key);

  @override
  State<RequestedMoneyListScreen> createState() => _RequestedMoneyListScreenState();
}

class _RequestedMoneyListScreenState extends State<RequestedMoneyListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<RequestedMoneyController>().getRequestedMoneyList(1,context ,reload: true );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(title: 'send_requests'.tr, onTap: (){
          Get.back();
        }),
        body: SafeArea(
          child: RefreshIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            onRefresh: () async {
              await Get.find<RequestedMoneyController>().getRequestedMoneyList(1,context ,reload: false );
              return true;
            },
            child: GetBuilder<RequestedMoneyController>(
                builder: (reqMoneyController) {
                  return reqMoneyController.isLoading ? CustomLoader(color: Theme.of(context).primaryColor) : CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverPersistentHeader(
                          pinned: true,
                          delegate: SliverDelegate(
                              child: Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL), height: 50, alignment: Alignment.centerLeft,
                                child: GetBuilder<RequestedMoneyController>(
                                  builder: (requestMoneyController){
                                    return ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          RequestTypeButton(text: 'pending'.tr, index: 0, requestMoneyList : requestMoneyController.pendingRequestedMoneyList),
                                          SizedBox(width: 10),
                                          RequestTypeButton(text: 'accepted'.tr, index: 1, requestMoneyList: requestMoneyController.acceptedRequestedMoneyList),
                                          SizedBox(width: 10),
                                          RequestTypeButton(text: 'denied'.tr, index: 2, requestMoneyList: requestMoneyController.deniedRequestedMoneyList),
                                          SizedBox(width: 10),
                                          RequestTypeButton(text: 'all'.tr, index: 3, requestMoneyList: requestMoneyController.requestedMoneyList),

                                        ]);
                                  },

                                ),
                              ))),

                      SliverToBoxAdapter(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: RequestedMoneyScreen(scrollController: _scrollController,isHome: false),
                          ),
                        ),
                      ),
                    ],
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}

class RequestTypeButton extends StatelessWidget {
  final String text;
  final int index;
  final List<RequestedMoney> requestMoneyList;

  RequestTypeButton({@required this.text, @required this.index, @required this.requestMoneyList});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Get.find<RequestedMoneyController>().setIndex(index),
      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Get.find<RequestedMoneyController>().requestTypeIndex == index ? ColorResources.getSecondaryHeaderColor() :  ColorResources.getWhiteAndBlack(),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: .5,color: ColorResources.getGreyColor())
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Text(text + '(${requestMoneyList.length})',
              style: rubikSemiBold.copyWith(color: Get.find<RequestedMoneyController>().requestTypeIndex == index
                  ? ColorResources.blackColor : ColorResources.getPrimaryTextColor())),
        ),
      ),
    );
  }
}


class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}