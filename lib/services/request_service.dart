import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mse_customer/util/locator.dart';

import 'api.dart';
import 'api_url.dart';

class RequestService {
  Api _api = locator<Api>();

  Future<dynamic> postRequestSubmit(_register) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://" + ApiUrl.baseUrl + ApiUrl.requestSubmit));
    request.headers.addAll(headers);
    Uint8List data = await _register.orderPhoto!.readAsBytes();
    List<int> list = data.cast();
    request.files.add(
        http.MultipartFile.fromBytes('order_photo', list, filename: 'myFile.png'));

    request.fields['location'] = _register.location!;
    request.fields['remarks'] = _register.remarks!;
    request.fields['materials_id'] = _register.materials_id!;
    request.fields['lat'] = _register.lat!;
    request.fields['lng'] = _register.lng!;
    request.fields['type'] = _register.type!;
    request.fields['estimated_weight'] = _register.weight!;
    if (_register.secondPic != null) {
      request.fields['second_pic'] = _register.secondPic!;
    }
    if (_register.secondPicContact != null) {
      request.fields['second_pic_contact'] = _register.secondPicContact!;
    }


    return _api.postMultipartRequest(request).then((dynamic res) async {
      return res;
    });
  }
}
