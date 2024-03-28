
import 'package:cydeva_lua_application/Test.dart';
import 'package:cydeva_lua_application/authentication/flash_screen/flash_screen.dart';
import 'package:cydeva_lua_application/authentication/profile_screen.dart/profile_screen.dart';
import 'package:cydeva_lua_application/authentication/sign_in_screen/signin_screen.dart';
import 'package:cydeva_lua_application/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
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
      home: TestPage(),
    );
  }
}
