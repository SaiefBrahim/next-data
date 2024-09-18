import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:next_data_saief_brahim/controllers/main_layout_controller.dart';
import 'package:next_data_saief_brahim/helpers/app_theme.dart';
import 'package:next_data_saief_brahim/helpers/images.dart';
import 'package:next_data_saief_brahim/views/posts_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  MainLayoutState createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout> with TickerProviderStateMixin {
  late AnimationController _controller;
  MainLayoutController mainLayoutController = MainLayoutController();
  late final iconList = <String>[
    AppImages.menuItem1,
    AppImages.menuItem2,
    AppImages.menuItem3,
    AppImages.menuItem4,
  ];
  late final iconNameList = <String>[
    'Home',
    'Posts',
    'Explore',
    'Account',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    mainLayoutController = Get.put(MainLayoutController());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: GetPlatform.isIOS ? true : false,
        top: false,
        child: Obx(() => Scaffold(
              extendBody: mainLayoutController.currentIndex.value == 0 ||
                  mainLayoutController.currentIndex.value == 1,
              resizeToAvoidBottomInset: false,
              body: GestureDetector(
                onTap: () {
                  if (!_controller.isDismissed) {
                    setState(() {
                      mainLayoutController.floatedButtonOpacity(1);
                    });
                    _controller.reverse();
                  }
                },
                child: const NotificationListener<ScrollNotification>(
                    child: Stack(
                  children: [PostsScreen()],
                )),
              ),
              bottomNavigationBar: Container(
                height: GetPlatform.isIOS ? 70 : 65,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: AnimatedBottomNavigationBar.builder(
                  activeIndex: mainLayoutController.currentIndex.value,
                  gapLocation: GapLocation.none,
                  notchSmoothness: NotchSmoothness.softEdge,
                  itemCount: iconList.length,
                  tabBuilder: (int index, bool isActive) {
                    final color = isActive ? AppTheme.primary : AppTheme.base;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          iconList[index],
                          height: 40,
                        ),
                        Text(
                          iconNameList[index],
                          style: TextStyle(
                              color:
                                  isActive ? AppTheme.primary : AppTheme.base,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                      ],
                    );
                  },
                  splashSpeedInMilliseconds: 300,
                  onTap: (index) {},
                ),
              ),
            )));
  }
}
