import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:store_app/auth/singin.dart';

import '../screens/home_screen.dart';

import '../widgets/home/signin_long_widget.dart';

class LoginScreenAuth extends StatelessWidget {
  LoginScreenAuth({super.key});

  final TextEditingController emailConttroll = TextEditingController();
  final TextEditingController passwordConttroll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SinginOrLoginwidget(
      titleName: "تسجيل الدخول",
      backName: 'انشاء حساب',
      passwordConttroll: passwordConttroll,
      emailConttroll: emailConttroll,
      onTap: () {
        Get.offAll(HomeScreen());
      },
      onaBack: () {
        Get.to(() => SigninScreenAuth());
      },
    );
  }
}
