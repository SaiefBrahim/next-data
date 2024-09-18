import 'package:flutter/material.dart';
import 'package:next_data_saief_brahim/helpers/app_theme.dart';

class Info {
  static message(String message,
      {GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
        BuildContext? context,
        Duration? duration,
        SnackBarBehavior snackBarBehavior = SnackBarBehavior.fixed}) {
    duration ??= const Duration(seconds: 3);

    SnackBar snackBar = SnackBar(
      duration: duration,
      content: Text(
        message,
        style: const TextStyle(color: AppTheme.onPrimary),
      ),
      backgroundColor: AppTheme.primary,
      behavior: snackBarBehavior,
    );

    if (scaffoldMessengerKey != null) {
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    } else if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {}
  }

  static error(String message,
      {GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
        BuildContext? context,
        Duration? duration,
        SnackBarBehavior snackBarBehavior = SnackBarBehavior.fixed}) {
    duration ??= const Duration(seconds: 3);

    SnackBar snackBar = SnackBar(
      duration: duration,
      content: Text(
        message,
        style: const TextStyle(color: AppTheme.onPrimary),
      ),
      backgroundColor: AppTheme.danger,
      behavior: snackBarBehavior,
    );

    if (scaffoldMessengerKey != null) {
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    } else if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {}
  }
}
