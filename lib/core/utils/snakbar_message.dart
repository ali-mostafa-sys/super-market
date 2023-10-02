import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarMessage {
  void showSnackBar(
      {required String message,
        required Color backgroundColor,
        required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.toString(),
          textDirection:TextDirection.rtl ,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}