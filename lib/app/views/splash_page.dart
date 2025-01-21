import 'package:flutter/material.dart';
import 'package:gallery_app/app/views/home_page.dart';
import 'package:get/get.dart';

import '../constants/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  chooseScreen(context) {
    Get.offAll(const HomePage());
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () => chooseScreen(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            const Text(
              'G A L L E R Y   A P P',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            const Expanded(child: SizedBox()),
            Text(
              "Developed by",
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "BasakCodez { }",
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

