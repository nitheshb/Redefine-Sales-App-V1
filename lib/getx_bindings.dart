import 'package:get/get.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';


class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<HomePageController>(HomePageController());
  }
}
