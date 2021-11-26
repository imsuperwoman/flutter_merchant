import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mse_customer/providers/auth_provider.dart';
import 'package:mse_customer/providers/base_model.dart';
import 'package:mse_customer/screens/widgets/decoration.dart';
import 'package:mse_customer/screens/widgets/widgets.dart';
import 'package:mse_customer/util/page_routes.dart';
import 'package:mse_customer/screens/widgets/long_button.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  final formKey = GlobalKey<FormState>();

  late String _mobileNo, _password;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    var doRegister = () {
      print('on doReset');

      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> respose =
            auth.forgetPassword(_mobileNo, _password);

        respose.then((response) {
          if (response['status']) {

            Navigator.pushReplacementNamed(context, PageRoutes.login);
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text(response['message'].toString().tr()),
                      content: Text("login_retry".tr()),
                      actions: [
                        ElevatedButton(
                            child: Text("bottom_ok".tr()),
                            onPressed: () => Navigator.pop(context))
                      ]);
                });
          }
        });
      }
    };

    return SafeArea(
        child: Stack(children: <Widget>[
      backgroundImage(context),
      Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: appBackground(""),
        body: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Image.asset(
                    "assets/images/data_security.gif",
                    height: 160,
                    width: 130,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Text("forgot_Password".tr(),
                        style: TextStyle(fontSize: 36))),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 56),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) =>
                      value!.isEmpty ? 'inEmptyPhoneNumber'.tr() : null,
                  onSaved: (value) => _mobileNo = value!,
                  decoration: buildInputDecoration("mobileNo".tr()),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 56),
                child: TextFormField(
                  obscureText: true,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  validator: (value) {
                    _password = value!;
                    if (value.isEmpty)
                      return 'inEmptyPassword'.tr();
                  },
                  onSaved: (value) => _password = value!,
                  decoration: buildInputDecoration("password".tr()),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 56),
                child: TextFormField(
                  obscureText: true,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  validator: (value) {
                    if (value!.isEmpty) return 'forget_inEmptyConfirmPass'.tr();
                    if (value != _password)
                      return 'forget_notMatchConfirm'.tr();
                    return null;
                  },
                  decoration: buildInputDecoration("confirm_password".tr()),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              if (auth.state == ViewState.Busy) loading("forget_loading".tr()) else longButtons('bottom_done'.tr(), doRegister)
            ],
          ),
        )),
      ),
    ]));
  }
}
