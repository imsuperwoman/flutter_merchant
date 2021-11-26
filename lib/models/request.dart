import 'package:image_picker/image_picker.dart';

class Request {
  String? datetime;
  XFile? orderPhoto;
  String? location;
  String? remarks;
  String? materialId;
  String? lat;
  String? lng;
  String? type;
  String? weight;
  String? secondPic;
  String? secondPicContact;


  Request(
      {this.datetime,
      this.orderPhoto,
      this.location,
      this.remarks,
      this.materialId,
      this.lat,
      this.lng,
      this.type,
      this.weight,
      this.secondPic,
      this.secondPicContact});
}
