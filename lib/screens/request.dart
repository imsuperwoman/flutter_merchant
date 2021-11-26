import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mse_customer/models/request.dart';
import 'package:mse_customer/models/user.dart';
import 'package:mse_customer/providers/request_provider.dart';
import 'package:mse_customer/providers/user_provider.dart';
import 'package:mse_customer/screens/widgets/decoration.dart';
import 'package:mse_customer/screens/widgets/long_button.dart';
import 'package:mse_customer/screens/widgets/widgets.dart';
import 'package:mse_customer/util/enum.dart';
import 'package:mse_customer/util/page_routes.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:location/location.dart';

class RequestScreen extends StatefulWidget {
  final Materials type;

  RequestScreen(this.type);
  @override
  _RequestScreenState createState() => _RequestScreenState(type);
}

class _RequestScreenState extends State<RequestScreen> {
  final formKey = GlobalKey<FormState>();
  final Request _request = new Request();
  final Location location = Location();
  final Materials type;
  _RequestScreenState(this.type);
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  late String gps;
  TextEditingController _controller = new TextEditingController();

  List<XFile> _imageFileList = [];

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    RequestProvider request = Provider.of<RequestProvider>(context);
    User _user = user.user;

    getGPS() async {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      _locationData = await location.getLocation();
      _locationData.longitude.toString();
      _request.lng =  _locationData.longitude.toString();
      _controller.text = _locationData.latitude.toString() +
          ',' +
          _locationData.longitude.toString();
    }

    _request.materialId = this.type.toString();
    _request.type = _user.type;

    var doSubmit = () async {
      print("doSubmit");

      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> response =
        request.postRequestSubmit(_request);

        response.then((response) {
          if (response['status'] == 200) {
           // var userData = response['data'];
           // User user = User.fromJson(userData);
           // Provider.of<UserProvider>(context, listen: false).setUser(user);
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
    return SafeArea(
        child: Stack(children: <Widget>[
      backgroundImage(context),
      Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: appBarColor( MaterialsExt.keys[this.type].toString().tr()+ " - " + _user.type!),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        style: form(),
                        validator: (value) =>
                            value!.isEmpty ? 'inEmptyLocation'.tr() : null,
                        onSaved: (value) => _request.location = value ,
                        decoration: buildRegisterDecoration("location".tr()),
                      ),
                      TextFormField(
                        style: form(),
                        keyboardType: TextInputType.number,
                        controller: _controller,
                        validator: (value) =>
                            value!.isEmpty ? 'inEmptyGPS'.tr() : null,
                        decoration: buildLocationDecoration("gps".tr(), getGPS),
                      ),
                      TextFormField(
                        style: form(),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => value!.isEmpty
                            ? 'inEmptyEstimateWeight'.tr()
                            : null,
                        onSaved: (value) => _request.weight = value,
                        decoration:
                            buildRegisterDecoration("estimate_weight".tr()),
                      ),
                      TextFormField(
                        style: form(),
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        onSaved: (value) => _request.remarks = value,
                        decoration: buildRegisterDecoration("remark".tr()),
                      ),
                      SizedBox(height: 10.0),
                      _imageFileList == null
                          ? SizedBox(
                              height: 10.0,
                            )
                          : buildGridView(),
                      emptyGridView(),
                      // buildGridView() ,
                      SizedBox(height: 20.0),
                      _user.type == 'corporate'
                          ? corporateContact()
                          : SizedBox(
                              height: 10.0,
                            ),
                      // Spacer(),
                      SizedBox(
                        height: 20.0,
                      ),
                      longButtons("bottom_submit".tr(), doSubmit),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                )),
          )),
    ]));
  }

  Widget corporateContact() {
    return Column(
      children: [
        label18Text("contact_2ndPerson".tr()),
        TextFormField(
          validator: (value) => value!.isEmpty ? 'inEmptyFullName'.tr() : null,
          onSaved: (value) => _request.secondPic = value,
          decoration: buildRegisterDecoration("fullName".tr()),
        ),
        TextFormField(
          validator: (value) =>
              value!.isEmpty ? 'inEmptyContactNumber'.tr() : null,
          onSaved: (value) => _request.secondPicContact = value,
          decoration: buildRegisterDecoration("contactNumber".tr()),
        ),
      ],
    );
  }

  Widget emptyGridView() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (_imageFileList.length != 6) {
              imageSelect();
            } else {
              maxImages();
            }
          },
          child:CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.transparent,
                backgroundImage: cameraImage().image),
          ),
        SizedBox(height: 10.0),
        Center(child: label18BoldText("images".tr())),
      ],
    );
  }

  Widget buildGridView() {
    return GridView.count(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(_imageFileList.length, (index) {
        print("================" + _imageFileList.length.toString());
        if (_imageFileList[index] is XFile) {
          print(index);
          print(_imageFileList[index].path);
          return Padding(
            padding: const EdgeInsets.all(spaceTiny),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                CircleAvatar(
                    radius: 70.0,
                    backgroundColor: Colors.white,
                    backgroundImage: _imageFileList[index] != null
                        ? Image.file(File(_imageFileList[index].path),
                                fit: BoxFit.cover)
                            .image
                        : profileImages().image),
                Container(
                    child: IconButton(
                      icon: Icon(Icons.delete_forever),
                      iconSize: 20,
                      color: Colors.red,
                      onPressed: () {
                        if (_imageFileList[index] != null) {
                          setState(() {
                            _imageFileList.removeAt(index);
                          });
                        }
                      },
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            offset: Offset(5.0, 5.0))
                      ],
                    )),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 10.0,
          );
        }
      }),
    );
  }

  final ImagePicker _picker = ImagePicker();

  _openCameraPicker(index) async {
    var image =
        await _picker.pickImage(source: ImageSource.camera, maxWidth: 800);

    if (image != null) {
      setState(() {
        _imageFileList.add(image);
        // ImageUploadModel imageUpload = new ImageUploadModel(isUploaded: false, imageFile: image, uploading: false);
        // _imageFileList!.replaceRange(index, index + 1, [image]);
        // print(imageUpload.imageFile.readAsBytes());
      });
    }
  }

  _openImagePicker(index) async {
    var image =
        await _picker.pickImage(source: ImageSource.gallery, maxWidth: 800);

    if (image != null) {
      setState(() {
        _imageFileList.add(image);
        //ImageUploadModel imageUpload = new ImageUploadModel(isUploaded: false, imageFile: image, uploading: false);
        //_imageFileList!.replaceRange(index, index + 1, [image]);
        // print(imageUpload.imageFile.readAsBytes());
      });
    }
  }

  void imageSelect() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: bottomText("profile_photo".tr()), actions: [
            TextButton.icon(
              icon: Icon(Icons.collections),
              label: greyText('gallery'.tr()),
              onPressed: () {
                // ignore: unnecessary_null_comparison
                var index = _imageFileList == null ? 0 : _imageFileList.length;
                print(index);
                _openImagePicker(index);
                Navigator.pop(context);
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.photo_camera),
              label: greyText('camera'.tr()),
              onPressed: () {
                // ignore: unnecessary_null_comparison
                var index = _imageFileList == null ? 0 : _imageFileList.length;
                print(index);
                // print(_imageFileList!.length.toString());
                _openCameraPicker(index);
                Navigator.pop(context);
              },
            ),
          ]);
        });
  }

  void maxImages() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: Text("max_6".tr()), actions: [
            ElevatedButton(
                child: Text("bottom_ok".tr()),
                onPressed: () => Navigator.pop(context))
          ]);
        });
  }
}
