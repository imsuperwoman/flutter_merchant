import 'package:flutter/material.dart';
import 'package:mse_customer/models/user.dart';
import 'package:mse_customer/providers/user_provider.dart';
import 'package:mse_customer/screens/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class WalletHistoryScreen extends StatefulWidget {
  @override
  _WalletHistoryScreenState createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends State<WalletHistoryScreen> {

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    User _user = user.user;

    return SafeArea(
        child: Stack(children: <Widget>[
      backgroundImage(context),
      Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: appBackground("wallet_history_title".tr()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundColor: Colors.lightGreenAccent,
                    radius: 80.0,
                    child: CircleAvatar(
                      radius: 70.0,
                      child: ClipOval(
                        child: Image.asset('assets/images/e-wallet.gif'),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Center(child: label20Text(_user.name!)),
                Center(child: label20Text(_user.contactNumber!)),
                SizedBox(
                  height: 40.0,
                ),
                labelUnBoldText("date".tr()),
                label18BoldText("02/06/2021"),
                SizedBox(height: 10.0),
                labelUnBoldText("time".tr()),
                label18BoldText("12:30pm"),
                SizedBox(
                  height: 10.0,
                ),
                labelUnBoldText("wallet_amount".tr()),
                label18Text("RM 200"),
                SizedBox(
                  height: 10.0,
                ),
                labelUnBoldText("status".tr()),
                label18Text("Complete"),
                SizedBox(
                  height: 10.0,
                ),
                labelUnBoldText("remark".tr()),
                label18Text("-"),
                SizedBox(
                  height: 10.0,
                ),
                labelUnBoldText("panding".tr()),
                label18Text("-"),
                SizedBox(
                  height: 10.0,
                ),
                labelUnBoldText("receipt".tr()),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                    child: noImages()),
              ],
            ),
          ),
        )),
    ]));
  }
}
