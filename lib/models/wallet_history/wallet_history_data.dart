class WalletHistoryData {
  String? id;
  String? date;
  String? des;
  String? amount;
  String? imageUrl;

  WalletHistoryData({
    this.id,
    this.date,
    this.des,
    this.amount,
    this.imageUrl,
  });

  factory WalletHistoryData.fromJson(Map<String, dynamic> json) => WalletHistoryData(
        id: json['id'] as String?,
        date: json['date'] as String?,
        des: json['des'] as String?,
        amount: json['amount'] as String?,
        imageUrl: json['imageUrl'] as String?,
      );

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'date': date,
  //       'des': des,
  //       'location': location,
  //       'weight': weight,
  //       'status': status,
  //       'imageUrl': imageUrl,
  //     };
}
