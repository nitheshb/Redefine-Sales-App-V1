import 'package:get/get.dart';
import 'package:redefineerp/Screens/Home/homepage_controller.dart';

import '../../themes/themes.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    changeTheme('light');
    super.onInit();
  }

  var currentTheme = 'light'.obs;

  void changeTheme(theme) {
    if (theme == 'light') {
      currentTheme.value = 'light';
      Get.changeTheme(Themes.light);
    } else if (theme == 'dark') {
      currentTheme.value = 'dark';
      Get.changeTheme(Themes.dark);
    } else if (theme == 'blue') {
      currentTheme.value = 'blue';
      Get.changeTheme(Themes.blueTheme);
    } else {
      currentTheme.value = 'green';
      Get.changeTheme(Themes.greenTheme);
    }
  }
}