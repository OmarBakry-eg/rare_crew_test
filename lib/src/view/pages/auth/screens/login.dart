import 'package:flutter/material.dart';
import 'package:rare_crew_test/src/view/pages/auth/widgets/auth_button.dart';
import 'package:rare_crew_test/src/view/pages/auth/widgets/reg_button.dart';
import 'package:rare_crew_test/src/view/pages/home/screens/home.dart';
import 'package:rare_crew_test/src/view/utils/custom_text_field.dart';
import 'package:rare_crew_test/src/view/utils/images_class.dart';
import 'package:rare_crew_test/src/view/utils/my_colors.dart';

import '../../../utils/custom_divider_title.dart';

class LoginPage extends StatelessWidget {
  final bool isSignup;
  const LoginPage({Key? key, this.isSignup = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
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
                  child: Column(
                    children: [
                      CustomTextField(
                        textEditingController: userNameController,
                        lable: 'Username',
                        hint: 'Omar',
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
                        textEditingController: passwordController,
                        lable: 'Password',
                        isPassword: true,
                        hint: '******',
                        prefixIcon: Image.asset(
                          ImageString.lockIcon,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AuthButton(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (c) => const HomePage(
                              //isSignup: !isSignup,
                              )));
                },
                title: isSignup ? "SIGNUP" : 'LOGIN',
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomDividerTitle(title: "OR"),
              const SizedBox(
                height: 20,
              ),
              RegButton(
                title: !isSignup ? "Signup" : "Login",
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (c) => LoginPage(
                                isSignup: !isSignup,
                              )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
