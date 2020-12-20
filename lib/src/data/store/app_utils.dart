import 'package:flutter/material.dart';

class AppUtils {
  dynamic dataNullCheck(dynamic data) {
    return data ?? '';
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  String camelCase(String data) {
    return '${data[0].toUpperCase()}${data.substring(1).toLowerCase()}';
  }
}
