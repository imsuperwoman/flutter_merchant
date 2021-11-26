class RequestHistoryData {
  String? id;
  String? date;
  String? des;
  String? location;
  String? weight;
  String? status;
  String? imageUrl;

  RequestHistoryData({
    this.id,
    this.date,
    this.des,
    this.location,
    this.weight,
    this.status,
    this.imageUrl,
  });

  factory RequestHistoryData.fromJson(Map<String, dynamic> json) => RequestHistoryData(
        id: json['id'] as String?,
        date: json['date'] as String?,
        des: json['des'] as String?,
        location: json['location'] as String?,
        weight: json['weight'] as String?,
        status: json['status'] as String?,
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
