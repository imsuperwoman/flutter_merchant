import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 16, color: Colors.white),
    errorStyle: TextStyle(color: Colors.white),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.yellow),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}

InputDecoration buildRegisterDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 14, color: Colors.white),
    errorStyle: TextStyle(color: Colors.white),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.yellow),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}

InputDecoration buildLocationDecoration(String hintText , Function fun) {
  return InputDecoration(
    suffixIcon: IconButton(
        icon: Icon(Icons.my_location),
        onPressed: () => fun(),
    ),
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 14, color: Colors.white),
    errorStyle: TextStyle(color: Colors.white),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.yellow),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}


InputDecoration buildDialogDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 14, color: Colors.black),
    errorStyle: TextStyle(color: Colors.black),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.yellow),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
  );
}
