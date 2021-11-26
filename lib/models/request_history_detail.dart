import 'dart:convert';


HistoryDetail  requestHistoryDetail(String str) => HistoryDetail.fromJson(json.decode(str));

class HistoryDetail  {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;

  HistoryDetail ({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.to
  });

  factory HistoryDetail.fromJson(Map<String, dynamic> json) => HistoryDetail(
        total: json['total'] as int?,
        perPage: json['per_page'] as int?,
        currentPage: json['current_page'] as int?,
        lastPage: json['last_page'] as int?,
        from: json['from'] as int?,
        to: json['to'] as int?
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
