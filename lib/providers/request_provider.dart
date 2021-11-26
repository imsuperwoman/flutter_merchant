import 'package:flutter/services.dart';
import 'package:mse_customer/models/request.dart';
import 'package:mse_customer/models/request_history_detail.dart';
import 'package:mse_customer/services/request_service.dart';
import 'package:mse_customer/util/locator.dart';

import 'base_model.dart';

class RequestProvider extends BaseModel{
  HistoryDetail _historyDetail = new HistoryDetail();

  Future<Map<String, dynamic>> postRequestSubmit(Request _request) async {
    final RequestService requestService = locator<RequestService>();
    setState(ViewState.Busy);
    final response = await requestService.postRequestSubmit(_request);
    setState(ViewState.Idle);
    return response;
  }

  Future<HistoryDetail> getRequestDetail(String username, String password) async {
    setState(ViewState.Busy);
    final String response = await rootBundle.loadString(
        'assets/json/request_history_detail.json');
    _historyDetail = requestHistoryDetail(response);
    setState(ViewState.Idle);
    return _historyDetail;
  }
}
