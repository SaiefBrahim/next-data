import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_data_saief_brahim/helpers/info_controller.dart';
import 'package:next_data_saief_brahim/views/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  late TextEditingController loginEmailController = TextEditingController();
  late TextEditingController loginPasswordController = TextEditingController();
  late TextEditingController signUpNameController = TextEditingController();
  late TextEditingController signUpEmailController = TextEditingController();
  late TextEditingController signUpPasswordController = TextEditingController();
  late TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  RxBool showPassword = false.obs;
  RxBool loginLoading = false.obs;
  RxBool signUpLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  final Connectivity connectivity = Connectivity();

  void onChangeShowPassword() {
    showPassword.value = !showPassword.value;
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

  String? validateConfirmPassword(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter password";
    } else if (!validateStringRange(
      text,
    )) {
      return "Password length must between 6 and 20";
    } else if (text != signUpPasswordController.value.text) {
      return "Passwords does not match";
    }
    return null;
  }

  signInWithEmailAndPassword() async {
    loginLoading.value = true;
    update();
    if (formKey.currentState!.validate()) {

        await auth
            .signInWithEmailAndPassword(
                email: loginEmailController.value.text.trim(),
                password: loginPasswordController.value.text.trim())
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
          Get.offAll(() => const SplashScreen(), transition: Transition.fadeIn);
        }).catchError((e) async {
          loginLoading.value = false;
          update();
          var hasInternet =
              await connectivity.checkConnectivity();
          if (hasInternet[0] == ConnectivityResult.none) {
            Info.error("Login Failed, Please check your internet connection",
                context: Get.context);
          } else {
            Info.error("Login Failed, Please check your credentials",
                context: Get.context);
          }
        });
    }
    loginLoading.value = false;
    update();
  }

  signUp() async {

    signUpLoading.value = true;
    update();
    if (signUpFormKey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(
              email: signUpEmailController.value.text.trim(),
              password: signUpPasswordController.value.text.trim())
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
        Get.offAll(() => const SplashScreen(), transition: Transition.fadeIn);
      }).catchError((e) async {
        signUpLoading.value = false;
        update();
        var hasInternet =
        await connectivity.checkConnectivity();
        if (hasInternet[0] == ConnectivityResult.none) {
          Info.error("Sign Up Failed, Please check your internet connection",
              context: Get.context);
        } else {
          Info.error("Sign Up Failed, $e", context: Get.context);
        }
        signUpLoading.value = false;
        update();
      });
    }
    signUpLoading.value = false;
    update();
  }
}
