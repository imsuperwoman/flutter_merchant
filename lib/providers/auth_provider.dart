import 'dart:async';
import 'package:mse_customer/models/user.dart';
import 'package:mse_customer/providers/base_model.dart';
import 'package:mse_customer/services/user_service.dart';
import 'package:mse_customer/util/locator.dart';

class AuthProvider extends BaseModel {
  Future<Map<String, dynamic>> login(
      String username, String password, String fcmToken) async {
    final UserService userService = locator<UserService>();
    setState(ViewState.Busy);
    final response =
        await userService.postUserLogin(username, password, fcmToken);
    setState(ViewState.Idle);
    return response;
  }

  Future<Map<String, dynamic>> register(User _user) async {
    final UserService userService = locator<UserService>();
    setState(ViewState.Busy);
    final response = await userService.postUserRegister(_user);
    setState(ViewState.Idle);
    return response;
  }

  Future<Map<String, dynamic>> forgetPassword(
      String mobileNumber, String password) async {
    var result;
    final UserService userService = locator<UserService>();
    setState(ViewState.Busy);

    //  Response response =
    //  await userService.postUserLogin(mobileNumber, password);
    setState(ViewState.Idle);
    return result;
  }
}
