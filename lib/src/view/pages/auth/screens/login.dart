import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/src/providers/auth_notifier_controller/auth_notifier_controller.dart';
import 'package:rare_crew_test/src/view/pages/auth/widgets/auth_button.dart';
import 'package:rare_crew_test/src/view/pages/auth/widgets/reg_button.dart';
import 'package:rare_crew_test/src/view/pages/home/screens/home.dart';
import 'package:rare_crew_test/src/view/utils/app_form_validator.dart';
import 'package:rare_crew_test/src/view/utils/custom_text_field.dart';
import 'package:rare_crew_test/src/view/utils/images_class.dart';
import 'package:rare_crew_test/src/view/utils/my_colors.dart';

import '../../../utils/custom_divider_title.dart';

class LoginPage extends StatelessWidget {
  final bool isSignup;
  const LoginPage({Key? key, this.isSignup = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        heightFactor: 1.9,
        child: SingleChildScrollView(
          child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ImageString.logoImg,
                width: 250,
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 2.0, color: MyColors.borderColor),
                    boxShadow: const [
                      BoxShadow(
                        color: MyColors.shadowColor,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final AuthNotifierController controller =
                          ref.read(authNotifierController.notifier);
                      return Form(
                        key: controller.formKey(isSignup),
                        child: Column(
                          children: [
                            CustomTextField(
                              textEditingController: controller.emailController,
                              lable: 'Username',
                              hint: 'Omar',
                              validator: AppFormValidator.generalEmailValidator,
                              prefixIcon: Image.asset(
                                ImageString.personIcon,
                                width: 25,
                                height: 25,
                              ),
                            ),
                            const Divider(
                              color: MyColors.borderColor,
                            ),
                            CustomTextField(
                              textEditingController: controller.passwordController,
                              lable: 'Password',
                              isPassword: true,
                              validator: AppFormValidator.generalPasswordValidator,
                              hint: '******',
                              prefixIcon: Image.asset(
                                ImageString.lockIcon,
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final AuthNotifierController controller =
                      ref.read(authNotifierController.notifier);
                  return AuthButton(
                    onTap: () async {
                      if (controller.formKey(isSignup).currentState!.validate()) {
                        await controller.authenticateUser(isSignup).then((value) {
                          if (value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const HomePage(
                                        //isSignup: !isSignup,
                                        )));
                          }
                          return value;
                        });
                      }
                    },
                    title: isSignup ? "SIGNUP" : 'LOGIN',
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomDividerTitle(title: "OR"),
              const SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final AuthNotifierController controller =
                      ref.read(authNotifierController.notifier);
                  return RegButton(
                    title: !isSignup ? "Signup" : "Login",
                    onTap: () {
                      controller.clearTextFields();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (c) => LoginPage(
                                    isSignup: !isSignup,
                                  )));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
