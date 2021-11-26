import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mse_customer/models/user.dart';
import 'package:mse_customer/providers/auth_provider.dart';
import 'package:mse_customer/providers/base_model.dart';
import 'package:mse_customer/providers/user_provider.dart';
import 'package:mse_customer/screens/widgets/decoration.dart';
import 'package:mse_customer/screens/widgets/widgets.dart';
import 'package:mse_customer/services/push_notification_service.dart';
import 'package:mse_customer/util/page_routes.dart';
import 'package:mse_customer/screens/widgets/long_button.dart';
import 'package:mse_customer/util/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  late String _userName, _password, _fcmToken;

  final PrefService _prefService = PrefService();

  @override
  void initState() {
    PushNotificationService().setUpFirebase();
    _prefService.readCache("password").then((value) {
      if (value != null) {
        return Navigator.of(context).pushNamed(PageRoutes.home);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    var doLogin = () async {
      print("doLogin");
      await messaging.getToken().then((value) async {
        print("FCM token: $value");
        _fcmToken = value!;
      });
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> response =
            auth.login(_userName, _password, _fcmToken);

        response.then((response) {
          if (response['status'] == 200) {
            var userData = response['data'];
            User user = User.fromJson(userData);
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, PageRoutes.home);
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text(response['message'].toString()),
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

    final additionalLabel = Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
                text: "login_forgotPassword".tr(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushNamed(PageRoutes.forgetPassword);
                  }),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
                text: "login_register".tr(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushNamed(PageRoutes.register);
                  }),
          ),
        )
      ],
    );

    final additionalButtom = Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(bottom: 30, top: 10),
                alignment: Alignment.center,
                child: GestureDetector(
                    child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/facebook.gif"),
                              fit: BoxFit.fill), // button text
                        )),
                    onTap: () {
                      //TODO
                      // User user = new User(identity: '1231', email: 'abc@abc.com', name: 'Andy Lua', mobilePhone: '012-12345678', type: 'PERSONAL');
                      // Provider.of<UserProvider>(context, listen: false).setUser(user);
                      Navigator.pushReplacementNamed(context, PageRoutes.home);
                    })),
            Container(
                padding: EdgeInsets.only(left: 20, bottom: 30, top: 10),
                alignment: Alignment.center,
                child: GestureDetector(
                    child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/google.gif"),
                              fit: BoxFit.fill), // button text
                        )),
                    onTap: () {
                      print("you clicked me");
                      //  User user = new User(identity: '817239812', email: 'abc@abc.com', name: 'Peter Lim', mobilePhone: '012-12345678', type:'CORPORATE');
                      //  Provider.of<UserProvider>(context, listen: false).setUser(user);
                      Navigator.pushReplacementNamed(context, PageRoutes.home);
                    }))
          ],
        ));

    return SafeArea(
        child: Stack(children: <Widget>[
      backgroundImage(context),
      Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: appBackground(""),
          body: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 56),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Image.asset(
                                  'assets/images/brandLogo.gif',
                                  fit: BoxFit.fill,
                                ))),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 56),
                            child: TextFormField(
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              autofocus: false,
                              validator: (value) => value!.isEmpty
                                  ? "inEmptyUsername".tr()
                                  : null,
                              onSaved: (value) => _userName = value!,
                              decoration: buildInputDecoration("username".tr()),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 56),
                            child: TextFormField(
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              autofocus: false,
                              obscureText: true,
                              validator: (value) => value!.isEmpty
                                  ? "inEmptyPassword".tr()
                                  : null,
                              onSaved: (value) => _password = value!,
                              decoration: buildInputDecoration("password".tr()),
                            )),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        auth.state == ViewState.Busy
                            ? loading("login_loading".tr())
                            : longButtons("login".tr(), doLogin),
                        SizedBox(
                          height: 10,
                        ),
                        additionalLabel,
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Row(children: <Widget>[
                            Expanded(
                              child: new Container(
                                  margin: EdgeInsets.only(right: 20.0),
                                  child: Divider(
                                    color: Colors.white,
                                  )),
                            ),
                            Text("login_socialMedial".tr()),
                            Expanded(
                              child: new Container(
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: Divider(
                                    color: Colors.white,
                                  )),
                            ),
                          ]),
                        ),
                        additionalButtom,
                      ])))),
    ]));
  }
}
