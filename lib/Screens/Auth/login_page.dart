import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/Auth/auth_controller.dart';
import 'package:redefineerp/Screens/OnBoarding/onboarding_page.dart';
import 'package:redefineerp/Widgets/task_sheet_widget.dart';
import 'package:redefineerp/themes/themes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put<AuthController>(AuthController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Login',
            style: Get.theme.kTabTextLg,
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: TextFormField(
              controller: controller.emailID,
              validator: (value) {
                if (!GetUtils.isEmail(value!)) {
                  return 'Please enter a valid email ID.';
                }
                return null;
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.check),
                labelText: 'Email',
                border: const OutlineInputBorder(),
                errorStyle: TextStyle(color: Get.theme.kRedColor),
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(
            () => TextField(
              maxLines: 1,
              obscureText: controller.showPass.value,
              controller: controller.password,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: '***********',
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    controller.showPass.value = !controller.showPass.value;
                  },
                  child: controller.showPass.value
                      ? const Icon(Icons.remove_red_eye_outlined)
                      : Icon(
                          Icons.remove_red_eye,
                          color: Get.theme.colorPrimaryDark,
                        ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Get.theme.colorPrimaryDark,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    fixedSize: Size(Get.size.width, 50),
                    textStyle: Get.theme.kNormalStyle),
                onPressed: () => {
                      Get.back(),
                      taskSheetWidget(initialChild: 0.5),
                    },
                child: const Text('Login')),
          ),
        ),
      ],
    );
  }
}
