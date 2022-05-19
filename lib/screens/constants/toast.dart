import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastMessage(String message) {
  Fluttertoast.showToast(
    textColor:  const Color(0xff228BDB),
    backgroundColor: Colors.transparent,
    msg: (message),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    fontSize: 16.0,
  );
}