import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GalleryController extends GetxController {
  RxInt selectedimg = 0.obs;

  RxBool isSelected = false.obs;
  RxString imagePath = ''.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    } else {}
  }
}
