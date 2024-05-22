import 'package:get/get.dart';

class ChangeScreenX extends GetxController {
  static ChangeScreenX get instance => Get.find();

  bool isSearchScreen = false;

  void toggleScreen() {
    isSearchScreen = !isSearchScreen;
    update();
  }
}