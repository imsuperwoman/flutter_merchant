import 'dart:convert';

import 'wallet_history_data.dart';

WalletHistory walletHistoryFromJson(String str) => WalletHistory.fromJson(json.decode(str));


class WalletHistory {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;
  List<WalletHistoryData>? data;

  WalletHistory({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.to,
    this.data,
  });

  factory WalletHistory.fromJson(Map<String, dynamic> json) => WalletHistory(
        total: json['total'] as int?,
        perPage: json['per_page'] as int?,
        currentPage: json['current_page'] as int?,
        lastPage: json['last_page'] as int?,
        from: json['from'] as int?,
        to: json['to'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => WalletHistoryData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

/*  Map<String, dynamic> toJson() => {
        'total': total,
        'per_page': perPage,
        'current_page': currentPage,
        'last_page': lastPage,
        'from': from,
        'to': to,
        'data': data?.map((e) => e.toJson()).toList(),
      };*/
}
