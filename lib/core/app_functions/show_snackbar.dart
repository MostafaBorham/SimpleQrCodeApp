import 'package:flutter/material.dart';

void showTextSnackBar({BuildContext? context, String? message}) {
  ScaffoldMessenger.of(context!)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message!)));
}
