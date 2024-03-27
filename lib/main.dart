import 'package:cydeva_lua_application/Authentication/FlashScreen/flash_screen.dart';
import 'package:cydeva_lua_application/Authentication/ProfileScreen/profile_screen.dart';
import 'package:cydeva_lua_application/Authentication/SignInScreen/signin_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const ProfileScreen(
      ),
    );
  }
}
