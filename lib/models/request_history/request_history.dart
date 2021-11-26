import 'dart:convert';

import 'package:mse_customer/models/request_history/request_history_data.dart';

RequestHistory requestHistoryFromJson(String str) => RequestHistory.fromJson(json.decode(str));

class RequestHistory {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;
  List<RequestHistoryData>? data;

  RequestHistory({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.to,
    this.data,
  });

  factory RequestHistory.fromJson(Map<String, dynamic> json) => RequestHistory(
        total: json['total'] as int?,
        perPage: json['per_page'] as int?,
        currentPage: json['current_page'] as int?,
        lastPage: json['last_page'] as int?,
        from: json['from'] as int?,
        to: json['to'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => RequestHistoryData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  // Map<String, dynamic> toJson() => {
  //       'total': total,
  //       'per_page': perPage,
  //       'current_page': currentPage,
  //       'last_page': lastPage,
  //       'from': from,
  //       'to': to,
  //       'data': data?.map((e) => e.toJson()).toList(),
  //     };
}
