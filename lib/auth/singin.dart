import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/widgets/home/signin_long_widget.dart';

import '../screens/home_screen.dart';

class SigninScreenAuth extends StatelessWidget {
  SigninScreenAuth({super.key});

  final TextEditingController emailConttroll = TextEditingController();
  final TextEditingController passwordConttroll = TextEditingController();
  final TextEditingController nameConttroll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SinginOrLoginwidget(
      backName: "تسجيل الدخول",
      titleName: 'انشاء حساب',
      passwordConttroll: passwordConttroll,
      emailConttroll: emailConttroll,
      nameConttroll: nameConttroll,
      onTap: () {
        Get.offAll(HomeScreen());
      },
      onaBack: () {
        Get.back();
      },
    );
  }
}
