import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_data_saief_brahim/helpers/info_controller.dart';
import 'package:next_data_saief_brahim/views/main_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInController extends GetxController {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool showPassword = false;
  bool showLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  bool validateStringRange(String text,
      [int minLength = 6, int maxLength = 30]) {
    return text.length >= minLength && text.length <= maxLength;
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter email";
    }
    return null;
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter password";
    } else if (!validateStringRange(
      text,
    )) {
      return "Password length must between 6 and 20";
    }
    return null;
  }

  signInWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        await auth
            .signInWithEmailAndPassword(
                email: emailController.value.text.trim(),
                password: passwordController.value.text.trim())
            .then((value) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (value.credential != null) {
            if (value.credential!.token != null) {
              prefs.setInt('token', value.credential!.token!);
            }
          }
          if (value.additionalUserInfo != null) {
            if (value.additionalUserInfo!.authorizationCode != null) {
              prefs.setString('authorizationCode',
                  value.additionalUserInfo!.authorizationCode!);
            }
          }
          Get.offAll(()=> const MainLayout());
        }).catchError((e) {
          showLoading = !showLoading;
          update();
          Info.error("Login Failed, Please check your credentials",
              context: Get.context);
          return;
        });
      } catch (e) {
        Info.error("Login Failed, Please check your credentials",
            context: Get.context);
        return;
      }
    }
  }
}
