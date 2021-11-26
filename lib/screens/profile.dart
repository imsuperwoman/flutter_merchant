import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mse_customer/models/user.dart';
import 'package:mse_customer/providers/user_provider.dart';
import 'package:mse_customer/screens/widgets/decoration.dart';
import 'package:mse_customer/screens/widgets/widgets.dart';
import 'package:mse_customer/screens/widgets/long_button.dart';
import 'package:mse_customer/util/validator.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  final formKey = GlobalKey<FormState>();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    User _user = user.user;

    var doUpdateProfile = () {
      print('on doUpdateProfile');

      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
      }
    };

    doLogout (){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
            (Route<dynamic> route) => false,
      );
    }
    return SafeArea(
        child: Stack(children: <Widget>[
      backgroundImage(context),
      Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: appBackground("profile_title".tr()),
        body: SingleChildScrollView(
            child: Form(
          key: formKey,
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
              Center(child: label20Text(_user.name!)),
              Center(child: label20Text(_user.contactNumber!)),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 56),
                child: TextFormField(
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  initialValue: _user.identity,
                  validator: (value) =>
                      value!.isEmpty ? 'register_inEmptyIdentity'.tr() : null,
                  onSaved: (value) => _user.identity = value!,
                  decoration: buildRegisterDecoration("register_identity".tr()),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 56),
                child: TextFormField(
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  initialValue: _user.email,
                  validator: (value) {
                    if (value!.isEmpty) return 'register_inEmptyEmail'.tr();
                    if (!validateEmail(value))
                      return 'register_inValidEmail'.tr();
                    return null;
                  },
                  onSaved: (value) => _user.email = value!,
                  decoration: buildRegisterDecoration("register_email".tr()),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 56),
                child: TextFormField(
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  initialValue: _user.address,
                  validator: (value) =>
                      value!.isEmpty ? 'register_inEmptyAddress'.tr() : null,
                  onSaved: (value) => _user.address = value,
                  decoration: buildRegisterDecoration("register_address".tr()),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: <Widget>[
              //     ElevatedButton(
              //       onPressed: () async {
              //         await context.setLocale(Locale('en'));
              //       },
              //       child: Text(
              //         "English",
              //       ),
              //     ),
              //     ElevatedButton(
              //       onPressed: () async {
              //         await context.setLocale(Locale('ms'));
              //       },
              //       child: Text(
              //         "Malay",
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 40.0,
              ),
              // auth.loggedInStatus == Status.Authenticating
              //     ? loading("profile_loading".tr())
              //     :
              longButtons('bottom_profile'.tr(), doUpdateProfile),
              SizedBox(
                height: 10.0,
              ),
              longButtons('bottom_logout'.tr(), doLogout)
            ],
          ),
        )),
      ),
    ]));
  }

  final ImagePicker _picker = ImagePicker();

  void imageSelect() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: bottomText("profile_photo".tr()), actions: [
            _image != null
                ? TextButton.icon(
                    icon:  Icon(Icons.delete_forever),
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
              icon:  Icon(Icons.collections),
              label: greyText('gallery'.tr()),
              onPressed: () {
                getImageFromGallery();
                Navigator.pop(context);
              },
            ),
            TextButton.icon(
              icon:  Icon(Icons.photo_camera),
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
    });
    print(_image?.path);
  }

  Future getImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _image = image;
    });
    print(_image?.path);
  }
}
