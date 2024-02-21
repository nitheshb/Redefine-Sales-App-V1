import 'package:get/get.dart';

class UnitController extends GetxController {
  RxBool foundation = false.obs;
  void onFoundChange(bool? value) {
    foundation.value = value!;
  }
}
