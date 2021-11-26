import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mse_customer/models/user.dart';
import 'package:mse_customer/providers/auth_provider.dart';
import 'package:mse_customer/providers/base_model.dart';
import 'package:mse_customer/providers/user_provider.dart';
import 'package:mse_customer/screens/widgets/bank_list.dart';
import 'package:mse_customer/screens/widgets/decoration.dart';
import 'package:mse_customer/screens/widgets/long_button.dart';
import 'package:mse_customer/screens/widgets/widgets.dart';
import 'package:mse_customer/util/custom_colors.dart';
import 'package:mse_customer/util/page_routes.dart';
import 'package:mse_customer/util/validator.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final User _registerUser = new User();
  List<dynamic> _bankList = jsonDecode(bankData);
  XFile? _image;
  late String _password;
  int bankLength = 10;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    var doRegister = () {
      print('on doRegister');

      if (_registerUser.image == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text('inEmptyAvatar'.tr()),
                  content: Text('uploadProfileImages'.tr()),
                  actions: [
                    ElevatedButton(
                        child: Text("bottom_ok".tr()),
                        onPressed: () => Navigator.pop(context))
                  ]);
            });
      } else {
        formKey.currentState!.save();
        if (formKey.currentState!.validate()) {
          final Future<Map<String, dynamic>> response =
              auth.register(_registerUser);

          response.then((response) {
            if (response['status'] == 200) {
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(_registerUser);
              Navigator.pushReplacementNamed(context, PageRoutes.home);
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text('register_fail'.tr()),
                        content: Text(response['message'].toString() +
                            '\n' +
                            response['errors'].toString()),
                        actions: [
                          ElevatedButton(
                              child: Text("bottom_ok".tr()),
                              onPressed: () => Navigator.pop(context))
                        ]);
                  });
            }
          });
        }
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 56),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    imageSelect();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.lightGreenAccent,
                    radius: 80.0,
                    child: CircleAvatar(
                        radius: 70.0,
                        backgroundColor: Colors.white,
                        backgroundImage: _image != null
                            ? Image.file(File(_image!.path), fit: BoxFit.cover)
                                .image
                            : profileImages().image),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                labelText("register_personal".tr()),
                personalData(),
                SwitchListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  title: labelText("register_notification".tr()),
                  value: _registerUser.notification,
                  onChanged: (bool value) {
                    setState(() => _registerUser.notification = value);
                  },
                ),
                bankDropDown(),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: form(),
                  validator: (value) {
                    if (value!.isEmpty) return 'inEmptyBankAccount'.tr();
                    return null;
                  },
                  onSaved: (String? value) =>
                      _registerUser.accountBankNo = value,
                  decoration:
                      buildRegisterDecoration("register_bankAccount".tr()),
                ),
                SizedBox(
                  height: 10.0,
                ),
                DropdownButtonFormField<String>(
                  value: _registerUser.type,
                  dropdownColor: CustomColor.primary,
                  iconEnabledColor: Colors.white,
                  isExpanded: true,
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      errorStyle: new TextStyle(
                        color: Colors.white,
                      )),
                  items: ['personal', 'corporate']
                      .map((label) => DropdownMenuItem(
                            child: Text(label.toString()),
                            value: label,
                          ))
                      .toList(),
                  hint: labelText('type'.tr()),
                  onSaved: (val) => _registerUser.type = val,
                  onChanged: (value) {
                    setState(() {
                      _registerUser.type = value;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value == null ? 'inEmptyType'.tr() : null,
                ),
                SizedBox(
                  height: 40.0,
                ),
                _registerUser.type == 'corporate'
                    ? labelText("register_corporate".tr())
                    : SizedBox(height: 10.0),
                _registerUser.type == 'corporate'
                    ? corporateData()
                    : SizedBox(height: 10.0),
                SizedBox(
                  height: 40.0,
                ),
                auth.state == ViewState.Busy
                    ? loading("register_loading".tr())
                    : longButtons('bottom_register'.tr(), doRegister),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        )),
      ),
    ]));
  }

  personalData() {
    return Column(children: [
      TextFormField(
        style: form(),
        autofocus: true,
        validator: (value) => value!.isEmpty ? 'inEmptyUsername'.tr() : null,
        onSaved: (String? value) => {_registerUser.username = value},
        decoration: buildRegisterDecoration("username".tr()),
      ),
      TextFormField(
        style: form(),
        validator: (value) => value!.isEmpty ? 'inEmptyPassword'.tr() : null,
        obscureText: true,
        onSaved: (value) => _password = value!,
        decoration: buildRegisterDecoration("password".tr()),
      ),
      TextFormField(
        style: form(),
        validator: (value) {
          if (value!.isEmpty) return 'forget_inEmptyConfirmPass'.tr();
          if (value != _password) return 'forget_notMatchConfirm'.tr();
          _registerUser.password = value;
          return null;
        },
        obscureText: true,
        onSaved: (value) => {_registerUser.password = value},
        decoration: buildRegisterDecoration("confirm_password".tr()),
      ),
      TextFormField(
        style: form(),
        validator: (value) => value!.isEmpty ? 'inEmptyFullName'.tr() : null,
        onSaved: (value) => _registerUser.name = value,
        decoration: buildRegisterDecoration("fullName".tr()),
      ),
      TextFormField(
        style: form(),
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 5,
        validator: (value) =>
            value!.isEmpty ? 'register_inEmptyAddress'.tr() : null,
        onSaved: (value) => _registerUser.address = value,
        decoration: buildRegisterDecoration("register_address".tr()),
      ),
      TextFormField(
        keyboardType: TextInputType.number,
        style: form(),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (value) =>
            value!.isEmpty ? 'inEmptyContactNumber'.tr() : null,
        onSaved: (value) => _registerUser.contactNumber = value,
        decoration: buildRegisterDecoration("contactNumber".tr()),
      ),
      TextFormField(
        keyboardType: TextInputType.number,
        style: form(),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(bankLength),
        ],
        validator: (value) =>
            value!.isEmpty ? 'register_inEmptyIdentity'.tr() : null,
        onSaved: (value) => _registerUser.identity = value,
        decoration: buildRegisterDecoration("register_identity".tr()),
      ),
      TextFormField(
        style: form(),
        validator: (value) {
          if (value!.isEmpty) return 'register_inEmptyEmail'.tr();
          if (!validateEmail(value)) return 'register_inValidEmail'.tr();
          return null;
        },
        onSaved: (value) => _registerUser.email = value,
        decoration: buildRegisterDecoration("register_email".tr()),
      )
    ]);
  }

  corporateData() {
    return Column(children: [
      TextFormField(
        style: form(),
        onSaved: (value) => _registerUser.companyName = value!,
        decoration: buildRegisterDecoration("register_companyName".tr()),
      ),
      TextFormField(
        style: form(),
        onSaved: (value) => _registerUser.companySsmNumber = value!,
        decoration: buildRegisterDecoration("register_companySSMNumber".tr()),
      ),
      TextFormField(
        style: form(),
        onSaved: (value) => _registerUser.companyContact = value!,
        decoration: buildRegisterDecoration("register_companyContact".tr()),
      ),
      TextFormField(
        style: form(),
        onSaved: (value) => _registerUser.companyAddress = value!,
        decoration: buildRegisterDecoration("register_address".tr()),
      ),
      TextFormField(
        style: form(),
        onSaved: (value) => _registerUser.personInCharge = value!,
        decoration: buildRegisterDecoration("register_personInCharge".tr()),
      )
    ]);
  }

  bankDropDown() {
    return DropdownButtonFormField(
      hint: labelText('register_bank'.tr()),
      icon: const Icon(Icons.arrow_drop_down),
      decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          errorStyle: new TextStyle(
            color: Colors.white,
          )),
      dropdownColor: CustomColor.primary,
      iconSize: 30,
      iconEnabledColor: Colors.white,
      isExpanded: true,
      style: new TextStyle(
        color: Colors.white,
      ),
      value: _registerUser.bankName,
      items: _bankList.map((item) {
        return DropdownMenuItem(
          child: Text(item['name']),
          value: item['name'],
        );
      }).toList(),
      onSaved: (value) => _registerUser.bankName = value as String?,
      onChanged: (value) {
        print(value);
        setState(() {
          _registerUser.bankName = value as String?;
        });
      },
      validator: (value) => value == null ? 'inEmptyBank'.tr() : null,
    );
  }

  final ImagePicker _picker = ImagePicker();

  void imageSelect() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: bottomText("profile_photo".tr()), actions: [
            _image != null
                ? TextButton.icon(
                    icon: Icon(Icons.delete_forever),
                    label: greyText('remove_photo'.tr()),
                    onPressed: () {
                      if (_image != null) {
                        setState(() {
                          _image = null;
                        });
                      }
                      Navigator.pop(context);
                    },
                  )
                : SizedBox(),
            TextButton.icon(
              icon: Icon(Icons.collections),
              label: greyText('gallery'.tr()),
              onPressed: () {
                getImageFromGallery();
                Navigator.pop(context);
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.photo_camera),
              label: greyText('camera'.tr()),
              onPressed: () {
                getImageFromCamera();
                Navigator.pop(context);
              },
            ),
          ]);
        });
  }

  Future getImageFromCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    setState(() {
      _image = image;
      _registerUser.image = image;
    });
    print(_image?.path);
  }

  Future getImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _image = image;
      _registerUser.image = image;
    });
    print(_image?.path);
  }
}
