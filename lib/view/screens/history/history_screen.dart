import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/transaction_history_controller.dart';
import 'package:six_cash/data/model/transaction_model.dart';
import 'package:six_cash/view/base/appbar_home_element.dart';
import 'package:six_cash/view/screens/history/widget/history_view.dart';

class HistoryScreen extends StatefulWidget {
  final Transactions transactions;
  HistoryScreen({Key key, this.transactions}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _tabController.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarHomeElement(title: 'transaction_history'.tr),
      body: RefreshIndicator(
        onRefresh: () async {
          await Get.find<TransactionHistoryController>().getTransactionData(1,reload: true);
          return true;
        },
        child: TransactionViewScreen(
            scrollController: _scrollController, searchController : _searchController, isHome: false),
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