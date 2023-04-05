import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  RxInt currentPage = 0.obs;
  onPageChnaged(int index) {
    currentPage.value = index;
  }
}
