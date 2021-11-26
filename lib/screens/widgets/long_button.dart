import 'package:flutter/material.dart';
import 'package:mse_customer/screens/widgets/widgets.dart';
import '../../util/custom_colors.dart';

Padding longButtons(String title, Function fun,
    {Color color: Colors.white, Color textColor: CustomColor.primary}) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56),
      child: MaterialButton(
        onPressed:() =>  fun(),
        textColor: textColor,
        color: color,
        child: SizedBox(
          width: double.infinity,
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
        height: 45,
        minWidth: 262,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ));
}

Padding longButtonsWithIcon(String title,  Function fun, Icon icon,
    {Color color: Colors.white, Color textColor: CustomColor.primary}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 56),
    child:  ElevatedButton.icon(
      icon: icon ,
      label:  bottomText(title),
      onPressed: () =>fun(),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0),
        ),
      ),
    ),
  );
}
