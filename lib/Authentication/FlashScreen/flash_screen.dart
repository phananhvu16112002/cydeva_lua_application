import 'package:cydeva_lua_application/Authentication/SignInScreen/signin_screen.dart';
import 'package:cydeva_lua_application/common/colors/Colors.dart';
import 'package:flutter/material.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (builder) => const SignInPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.flashScreenColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logoFlash.png',
              width: 188,
              height: 250,
            ),
            const SizedBox(
              height: 36,
            ),
            Image.asset('assets/images/LUA.png')
          ],
        ),
      ),
    );
  }
}
