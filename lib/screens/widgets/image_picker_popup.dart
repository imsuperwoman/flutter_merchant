import 'package:flutter/material.dart';
import 'package:mse_customer/screens/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';

class ImagePickerPopup extends StatelessWidget {
  final _showMenuSelection;
  final index;

  ImagePickerPopup(this._showMenuSelection, {this.index = -1});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      onSelected: index != -1
          ? (value) => _showMenuSelection(value, index)
          : (value) => _showMenuSelection(value),
      child: Container(
          padding: EdgeInsets.all(spaceTiny),
          child: Icon(
            Icons.edit,
            size: spaceLarge,
            color: Colors.black54,
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
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          value: "_0",
          child: Text(
              "gallery".tr()),
        ),
        PopupMenuItem<String>(
          value: "_1",
          child:
          Text("camera".tr()),
        ),
        PopupMenuItem<String>(
          value: "_2",
          child: Text("remove_photo".tr()),
        ),
      ],
    );
  }
}



