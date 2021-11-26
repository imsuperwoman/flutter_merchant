import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mse_customer/util/locator.dart';

import 'api.dart';
import 'api_url.dart';

class UserService {
  Api _api = locator<Api>();

  Future<dynamic> postUserLogin(
      String username, String password, String fcmToken) async {
    return _api.post(ApiUrl.login, {
      "username": username,
      "password": password,
      "device_key": fcmToken
    }).then((dynamic res) async {
      return res;
    });
  }

  Future<dynamic> postUserRegister(_user) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://" + ApiUrl.baseUrl + ApiUrl.register));
    request.headers.addAll(headers);
    Uint8List data = await _user.image!.readAsBytes();
    List<int> list = data.cast();
    request.files.add(
        http.MultipartFile.fromBytes('avatar', list, filename: 'myFile.png'));

    request.fields['name'] = _user.name!;
    request.fields['email'] = _user.email!;
    request.fields['password'] = _user.password!;
    request.fields['password_confirmation'] = _user.password!;
    request.fields['username'] = _user.username!;
    request.fields['address'] = _user.address!;
    request.fields['nric'] = _user.identity!;
    request.fields['type'] = _user.type!;
    if (_user.companyName != null) {
      request.fields['company_name'] = _user.companyName!;
    }
    if (_user.companyAddress != null) {
      request.fields['company_address'] = _user.companyAddress!;
    }
    if (_user.companySsmNumber != null) {
      request.fields['company_ssm_number'] = _user.companySsmNumber!;
    }
    if (_user.companyContact != null) {
      request.fields['company_contact'] = _user.companyContact!;
    }
    request.fields['account_bank_no'] = _user.accountBankNo!;
    request.fields['bank_name'] = _user.bankName!;
    request.fields['contact_number'] = _user.contactNumber!;
    request.fields['notification_value'] = _user.notification ? '1' : '0';

    return _api.postMultipartRequest(request).then((dynamic res) async {
      return res;
    });
  }
}
