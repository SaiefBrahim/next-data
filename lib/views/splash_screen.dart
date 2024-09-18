import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_data_saief_brahim/helpers/app_theme.dart';
import 'package:next_data_saief_brahim/helpers/images.dart';
import 'package:next_data_saief_brahim/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SplashController controller;

  @override
  initState() {
    super.initState();
    controller = Get.put(SplashController());
    controller.checkInternetAndRedirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: Obx(() {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: controller.isLoading.value ? 0.85 : 1.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: AnimatedSlide(
                  offset: controller.isLoading.value
                      ? const Offset(0, -0.3) // Slide up when loading
                      : Offset.zero,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: SvgPicture.asset(
                    AppImages.logoLight,
                    height: 100,
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: controller.isLoading.value ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: controller.isLoading.value
                    ? const Column(
                        children: [
                          SizedBox(height: 10),
                          CircularProgressIndicator(color: Colors.white),
                        ],
                      )
                    : Container(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
