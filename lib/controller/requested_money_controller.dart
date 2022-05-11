
import 'package:six_cash/data/api/api_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:six_cash/data/model/response/requested_money_model.dart';
import 'package:six_cash/data/repository/requested_money_repo.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';


class RequestedMoneyController extends GetxController implements GetxService {
  final RequestedMoneyRepo requestedMoneyRepo;
  RequestedMoneyController({@required this.requestedMoneyRepo});



  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<RequestedMoney> _requestedMoneyList = [];
  List<RequestedMoney> get requestedMoneyList => _requestedMoneyList;
  List<RequestedMoney> _pendingRequestedMoneyList =[];
  List<RequestedMoney> get pendingRequestedMoneyList => _pendingRequestedMoneyList;
  List<RequestedMoney> _acceptedRequestedMoneyList =[];
  List<RequestedMoney> get acceptedRequestedMoneyList =>_acceptedRequestedMoneyList;
  List<RequestedMoney> _deniedRequestedMoneyList =[];
  List<RequestedMoney> get deniedRequestedMoneyList => _deniedRequestedMoneyList;
  int _offset = 1;
  int _pageSize;
  List<int> _offsetList = [];
  int get offset => _offset;
  List<int> get offsetList => _offsetList;
  int get pageSize => _pageSize;
  Future getRequestedMoneyList(int offset, BuildContext context, {bool reload = false}) async{
    if(reload) {
      _offsetList = [];
      _requestedMoneyList = [];
      _pendingRequestedMoneyList =[];
      _acceptedRequestedMoneyList =[];
      _deniedRequestedMoneyList =[];
    }
    _isLoading = true;
    Response response = await requestedMoneyRepo.getRequestedMoneyList();
    print('requested  : $response');
    // if(response.statusCode == 200) {
    //
    // }else {
    //   ApiChecker.checkApi(response);
    // }
    if(response.body['requested_money'] != null && response.body['requested_money'] != {} && response.statusCode == 200){
      _requestedMoneyList =[];
      _pendingRequestedMoneyList =[];
      _acceptedRequestedMoneyList =[];
      _deniedRequestedMoneyList =[];
        response.body['requested_money'].forEach((requested) {
          RequestedMoney req = RequestedMoney.fromJson(requested);
          if(req.type == AppConstants.APPROVED){
            _acceptedRequestedMoneyList.add(req);
          }else if(req.type == AppConstants.PENDING){
            _pendingRequestedMoneyList.add(req);
          }else if(req.type == AppConstants.DENIED){
            _deniedRequestedMoneyList.add(req);
          }
          _requestedMoneyList.add(req);
        });


      _isLoading = false;
      update();
    }else {
      ApiChecker.checkApi(response);
      _isLoading = false;
      update();
    }

  }

  Future<void> acceptRequest(BuildContext context, int requestId, String pin) async {
    _isLoading = true;
    update();
    Response response = await requestedMoneyRepo.approveRequestedMoney(requestId, pin);
    print(response.status);

    if(response.statusCode == 200) {
      getRequestedMoneyList(offset, context);
      Get.back();
      Navigator.pop(context);
      _isLoading = false;
    }else {
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
   update();
  }
  Future<void> denyRequest(BuildContext context, int requestId, String pin ) async {
    _isLoading = true;
    update();
    Response response = await requestedMoneyRepo.denyRequestedMoney(requestId, pin);
    if(response.statusCode == 200) {
      getRequestedMoneyList(offset, context);
      showCustomSnackBar('request_denied_successfully'.tr,isError: false);
      Get.back();
      Navigator.pop(context);
      _isLoading = false;
    }else {
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }


  int _requestTypeIndex = 0;
  int get requestTypeIndex => _requestTypeIndex;

  void setIndex(int index) {
    _requestTypeIndex = index;
    update();
  }
  void showBottomLoader() {
    _isLoading = true;
    update();
  }
}