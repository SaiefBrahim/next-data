import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:next_data_saief_brahim/helpers/app_theme.dart';
import 'package:next_data_saief_brahim/views/auth/login.dart';
import 'package:next_data_saief_brahim/views/main_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

///import 'package:next_data_saief_brahim/views/main_layout.dart';

class SplashController extends GetxController {
  late SharedPreferences prefs;
  final Connectivity connectivity = Connectivity();
  RxBool isLoading = false.obs;

  //late UserController userCtrl;

  @override
  void onInit() {
    super.onInit();
    //userCtrl = Get.put(UserController());
  }

  Future<void> checkInternetAndRedirect() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    isLoading.value = true;
    update();
    prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 5));
    var hasInternet =
        await connectivity.checkConnectivity() != ConnectivityResult.none;
    if (hasInternet) {
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAll(() => const MainLayout(), transition: Transition.fadeIn);
      } else {
        Get.offAll(() => const LoginScreen(), transition: Transition.fadeIn);
      }
    } else {
      Dialog(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              const Center(
                  child: Icon(
                Icons.signal_wifi_off_outlined,
                size: 40,
                color: AppTheme.base,
              )),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: const Center(
                    child: Text("TRY AGAIN",style:
                    TextStyle(fontWeight: FontWeight.w600,letterSpacing: 0.3,color:AppTheme.light),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: const Center(
                    child: Text("TRY AGAIN",style:
                    TextStyle(fontWeight: FontWeight.w600,letterSpacing: 0.3,color:AppTheme.light),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 18, horizontal: 16)),
                          elevation: const WidgetStatePropertyAll(0),
                          shape:
                              WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ))),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("TRY AGAIN",style:
                          TextStyle(fontWeight: FontWeight.w600,letterSpacing: 0.3,color:AppTheme.onPrimary),
                        ),
                ),
              )
              )],
          ),
        ),
      );
    }
  }
}
