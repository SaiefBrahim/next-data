import 'package:get/get.dart';

class MainLayoutController extends GetxController {
  double contentOpacity = 1;
  RxInt currentIndex = 1.obs;

  void floatedButtonOpacity(double opacity) async {
    contentOpacity = opacity;
    update();
  }
}
