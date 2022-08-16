import 'package:get/get.dart';

class HomePageController extends GetxController {
  var tabIndex = 0.obs;
   var bottomBarIndex = 0.obs;

   void bottomBarOnTap(int index) {
    bottomBarIndex.value = index;
    switch (index) {
      case 0:
        // TODO:
        break;
      case 1:
                // TODO:

        break;
      case 2:
                // TODO:

        break;
      case 3:
                // TODO:

        break;
    }
  }
}
