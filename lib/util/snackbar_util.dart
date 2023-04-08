import 'package:flutter/material.dart';

extension SnackBarUtil on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      action: action,
    ));
  }
}
