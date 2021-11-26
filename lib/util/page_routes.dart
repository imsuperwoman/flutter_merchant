import 'package:flutter/cupertino.dart';
import 'package:mse_customer/screens/home.dart';
import 'package:mse_customer/screens/forget_password.dart';
import 'package:mse_customer/screens/login.dart';
import 'package:mse_customer/screens/register.dart';

class PageRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forgetPassword';
  static const String home = '/home';

  Map<String, WidgetBuilder> routes() {
    return {
      login: (context) => Login(),
      register: (context) => Register(),
      home: (context) => Home(),
      forgetPassword: (context) => ForgetPassword()
    };
  }
}
