import 'package:cydeva_lua_application/screens/authentication/sign_in_screen/bloc/signin_bloc.dart';
import 'package:cydeva_lua_application/screens/authentication/sign_in_screen/signin_screen.dart';
import 'package:cydeva_lua_application/common/colors/Colors.dart';
import 'package:cydeva_lua_application/screens/my_account/my_account.dart';
import 'package:cydeva_lua_application/screens/user_screen/user_screen.dart';
import 'package:cydeva_lua_application/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  SecureStorage secureStorage = SecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    var phoneNumber = await secureStorage.readSecureData('phone_number');
    var address = await secureStorage.readSecureData('address');
    var fullname = await secureStorage.readSecureData('full_name');
    var avatar = await secureStorage.readSecureData('avatar');


    Future.delayed(const Duration(seconds: 3), () {
      if (phoneNumber.isEmpty && address.isEmpty && fullname.isEmpty && avatar.isEmpty) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (builder) => BlocProvider(
                      create: (context) => SigninBloc(),
                      child: const SignInPage(),
                    )));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (builder) => const UserScreen()));
      }
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
