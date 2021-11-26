import 'package:flutter/material.dart';
import 'package:mse_customer/util/custom_colors.dart';

const spaceTiny = 10.0;
const spaceLarge = 16.0;

String noImage ='assets/images/noImage.jpg' ;

TextStyle form(){
 return TextStyle(fontSize: 14, color: Colors.white);
}

Image profileImages(){
  return Image.asset(
    'assets/images/profile.png',
      fit:BoxFit.cover,
    color: Colors.white,
  );
}

Image cameraImage(){
  return Image.asset(
    'assets/images/camera_icon.gif',
    fit:BoxFit.cover
  );
}

Image noImages(){
  return Image.asset(
'assets/images/noImage.jpg',
 );
}

AppBar appBackground(String title) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: headerText(title),
  );
}

AppBar appBarColor(String title) {
  return AppBar(
    backgroundColor: Colors.lightGreenAccent,
    centerTitle: true,
    title:  appBarText(title),
  );
}

Image backgroundImage(BuildContext context) {
  return Image.asset(
    "assets/images/background.jpg",
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    fit: BoxFit.cover,
  );
}

Row loading(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[CircularProgressIndicator(), Text(text)],
  );
}

Text labelText(String title) {
  return Text(title,
      style: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white));
}

Text labelUnBoldText(String title) {
  return Text(title,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 14, color: Colors.white, ));
}

Text label20Text(String title) {
  return Text(title,
      style: TextStyle(
        fontSize: 20, color: Colors.white,fontWeight: FontWeight.w400 ));
}

Text label18BoldText(String title) {
  return Text(title,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 18, color: Colors.white,fontWeight: FontWeight.w700  ));
}

Text label18Text(String title) {
  return Text(title,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 18, color: Colors.white ));
}

Text labelBigRightText(String title) {
  return Text(title,
      textAlign: TextAlign.right,
      style: TextStyle(
          fontSize: 20, color: Colors.white ));
}

Text headerText(String title) {
  return Text(title,
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white));
}

Text dialogText(String title) {
  return Text(title,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w200, color: Colors.black));
}

Text dialogBoldText(String title) {
  return Text(title,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black));
}

Text bottomText(String title) {
  return Text(title,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: CustomColor.primary));
}

Text greyText(String title) {
  return Text(title,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey));
}

Text appBarText(String title) {
  return Text(title,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: CustomColor.primary));
}
