import 'package:get/get.dart';
import 'package:redefineerp/app_main_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AppMainController>(AppMainController());
  }
}
