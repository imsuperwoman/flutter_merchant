import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mse_customer/models/wallet_history/wallet_history.dart';
import 'package:mse_customer/models/wallet_history/wallet_history_data.dart';
import 'package:mse_customer/screens/wallet_history.dart';
import 'package:mse_customer/screens/widgets/bank_list.dart';
import 'package:mse_customer/screens/widgets/decoration.dart';
import 'package:mse_customer/screens/widgets/widgets.dart';
import 'package:mse_customer/util/custom_colors.dart';
import 'package:mse_customer/screens/widgets/long_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final formKey = GlobalKey<FormState>();
  int currentPage = 1;
  late int totalPages;
  late int selectedRadioTile = 1;
  List<WalletHistoryData> history = [];
  String? _selectedBank,_bankAccount,_fullName ;
  List<dynamic> _bankList = jsonDecode(bankData);

  final RefreshController refreshController =
  RefreshController(initialRefresh: true);

  Future<bool> getWallettHistoryData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }

    final String response =
    await rootBundle.loadString('assets/json/wallet_history.json');
    // if (response.statusCode == 200) {
    final result = walletHistoryFromJson(response);

    if (isRefresh) {
      history = result.data!.cast<WalletHistoryData>();
    } else {
      history.addAll(result.data!.cast<WalletHistoryData>());
    }

    currentPage++;

    totalPages = result.total!;

    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //AuthProvider auth = Provider.of<AuthProvider>(context);

   var doNewRequest = () {
      print('on doNewRequest');

      showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              title: Center(child: bottomText('wallet_title'.tr())),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  setSelectedRadioTile(int val) {
                    setState(() {
                      selectedRadioTile = val;
                    });
                  }

                  return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        RadioListTile<int>(
                          value: 1,
                          groupValue: selectedRadioTile,
                          title: dialogText("Bank"),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                dialogBoldText("MAYBANK"),
                                dialogText('Bank Account'),
                                dialogBoldText('12345678'),
                              ]),
                          onChanged: (val) {
                            setSelectedRadioTile(val!);
                          },
                          activeColor: CustomColor.primary,
                          selected: selectedRadioTile == 1,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        RadioListTile<int>(
                          value: 2,
                          groupValue: selectedRadioTile,
                          title: DropdownButton<String?>(
                            hint: dialogText('register_bank'.tr()),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 30,
                            iconEnabledColor: Colors.black,
                            isExpanded: true,
                            value: _selectedBank,
                            items: _bankList.map((item) {
                              return DropdownMenuItem<String?>(
                                child: Text(item['name']),
                                value: item['name'],
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              print(value);
                              setState(() {
                                _selectedBank = value!;
                              });
                            },
                          ),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  validator: (value) => value!.isEmpty
                                      ? 'inEmptyBankAccount'.tr()
                                      : null,
                                  onSaved: (value) => _bankAccount = value!,
                                  decoration: buildDialogDecoration(
                                      "register_bankAccount".tr()),
                                ),
                                TextFormField(
                                  validator: (value) => value!.isEmpty
                                      ? 'inEmptyFullName'.tr()
                                      : null,
                                  onSaved: (value) => _fullName = value!,
                                  decoration: buildDialogDecoration(
                                      "fullName".tr()),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) => value!.isEmpty
                                      ? 'wallet_inEmptyAmount'.tr()
                                      : null,
                                  onSaved: (value) => _fullName = value!,
                                  decoration: buildDialogDecoration(
                                      "wallet_amount".tr()),
                                )
                              ]),
                          onChanged: (val) {
                            setSelectedRadioTile(val!);
                          },
                          activeColor: CustomColor.primary,
                          selected: selectedRadioTile == 2,
                        ),
                      ]);
                },
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 100, bottom: 30, top: 10),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    InkWell(
                      child: greyText('bottom_cancel'.tr()),
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                      child: bottomText('bottom_done'.tr()),
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ]),
                )
              ],
            );
          });
    };
    return SafeArea(
        child: Stack(children: <Widget>[
      backgroundImage(context),
      Scaffold(
        appBar: appBackground(""),
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Center(
                child: Image.asset('assets/images/QRCode.jpg',
                    height: 200, width: 200, fit: BoxFit.cover)),
            SizedBox(
              height: 20.0,
            ),
            Center(child: headerText("wallet_point".tr())),
            Divider(color: Colors.white),
            Center(child: headerText("wallet_history".tr())),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Colors.white),
            ),
            Flexible(
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: 20),
              child: SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                onRefresh: () async {
                  final result = await getWallettHistoryData(isRefresh: true);
                  if (result) {
                    refreshController.refreshCompleted();
                  } else {
                    refreshController.refreshFailed();
                  }
                },
                onLoading: () async {
                  final result = await getWallettHistoryData();
                  if (result) {
                    refreshController.loadComplete();
                  } else {
                    refreshController.loadFailed();
                  }
                },
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final histories = history[index];
                    return ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          labelUnBoldText(histories.des ?? ""),
                          labelText(histories.date ?? ""),
                          labelUnBoldText(histories.amount ?? "0.00"),
                        ],
                      ),
                      onTap: (){
                        print(histories.id);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => WalletHistoryScreen()),
                      );
                      },
                      trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                            placeholder: noImage,
                            image: histories.imageUrl ?? "",
                            imageErrorBuilder: (context, error, stackTrace) {
                              return noImages();
                            },
                          )),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.white),
                  itemCount: history.length,
                ),
              ),
            ),
    ),
            longButtonsWithIcon('bottom_newRequest'.tr(), doNewRequest,
                Icon(Icons.add_photo_alternate, color: CustomColor.primary)),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    ]));
  }
}
