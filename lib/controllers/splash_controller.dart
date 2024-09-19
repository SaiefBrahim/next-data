import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:next_data_saief_brahim/controllers/post_screen_controller.dart';
import 'package:next_data_saief_brahim/helpers/app_theme.dart';
import 'package:next_data_saief_brahim/views/auth/login.dart';
import 'package:next_data_saief_brahim/views/main_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashController extends GetxController {
  late SharedPreferences prefs;
  RxBool isLoading = false.obs;
  late PostsScreenController postsScreenController;

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<PostsScreenController>()) {
      postsScreenController = Get.find<PostsScreenController>();
    } else {
      postsScreenController = Get.put(PostsScreenController());
    }
  }

  Future<void> checkInternetAndRedirect() async {
    await Future.delayed(const Duration(seconds: 2));
    prefs = await SharedPreferences.getInstance();
    isLoading.value = true;
    update();
    await Future.delayed(const Duration(seconds: 2));

    if (FirebaseAuth.instance.currentUser != null) {
      isLoading.value = true;
      update();
      await postsScreenController.fetchData();
      isLoading.value = false;
      update();
      Get.offAll(() => const MainLayout(), transition: Transition.fadeIn);
    } else {
      isLoading.value = false;
      update();
      Get.offAll(() => const LoginScreen(), transition: Transition.fadeIn);
    }
  }
}
