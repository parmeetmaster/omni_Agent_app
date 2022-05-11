import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/transaction_history_controller.dart';
import 'package:six_cash/data/model/transaction_model.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/no_data_screen.dart';
import 'package:six_cash/view/screens/history/history_screen.dart';
import 'package:six_cash/view/screens/history/widget/history_shimmer.dart';


import 'history_widget.dart';
class TransactionViewScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final ScrollController scrollController;
  final TextEditingController searchController;
  final bool isHome;
  final String type;
   TransactionViewScreen({Key key, this.scrollController, this.searchController, this.isHome, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<TransactionHistoryController>(id: 'transaction_list', builder: (transactionHistory){
      return  CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: SliverDelegate(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Container(
                      child: TextField(
                        controller: searchController,
                        style: rubikMedium.copyWith(color: ColorResources.COLOR_BLACK),
                        decoration: InputDecoration(

                            prefixIcon: Icon(Icons.search),
                            hintText: 'search_for_previous'.tr,
                            // hintStyle: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(style: BorderStyle.none, width: 0),
                            ),
                            hintStyle: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).hintColor),
                            filled: true, fillColor: ColorResources.getSearchBg()),
                        maxLines: 1,
                        onChanged: (value) {
                          transactionHistory.transactionSearch(value.toLowerCase());
                        },

                      ),
                    ),
                  ),

              ),
          ),
          SliverToBoxAdapter(
            child: Scrollbar(
              child: TransactionWidget(isHome: isHome),
            ),
          ),
        ],

      );



    });
  }
}
class TransactionWidget extends StatelessWidget {
  final bool isHome;
  const TransactionWidget({Key key, this.isHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionHistoryController>(
      builder: (transactionHistory) {
        List<Transactions> transactionList;
        transactionList = transactionHistory.filterTransactionList;
        return Column(
          children: [
            Column(children: [!transactionHistory.firstLoading ? transactionList.length != 0 ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: transactionList.length,
                  itemBuilder: (ctx,index){
                    return Container(
                        child: TransactionHistoryCardWidget(transactions: transactionList[index]));
                  }),
            ) : NoDataFoundScreen(fromHome: isHome,): HistoryShimmer(),

              transactionHistory.isLoading ? Center(child: Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
              )) : SizedBox.shrink(),
            ],),
          ],
        );
      }
    );
  }
}

