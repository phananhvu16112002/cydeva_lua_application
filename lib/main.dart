import 'package:cydeva_lua_application/screens/authentication/register_screen/bloc/register_bloc.dart';
import 'package:cydeva_lua_application/screens/home_screen/home_screen.dart';
import 'package:cydeva_lua_application/screens/my_account/my_account.dart';
import 'package:cydeva_lua_application/screens/my_account/bloc/my_account_bloc.dart';
import 'package:cydeva_lua_application/screens/test_screen/Test.dart';
import 'package:cydeva_lua_application/screens/authentication/flash_screen/flash_screen.dart';
import 'package:cydeva_lua_application/screens/authentication/register_screen/register_screen.dart';
import 'package:cydeva_lua_application/screens/authentication/sign_in_screen/bloc/signin_bloc.dart';
import 'package:cydeva_lua_application/screens/authentication/sign_in_screen/signin_screen.dart';
import 'package:cydeva_lua_application/firebase_options.dart';
import 'package:cydeva_lua_application/screens/setting_screen/setting_screen.dart';
import 'package:cydeva_lua_application/screens/test_screen/test_screen_bloc.dart';
import 'package:cydeva_lua_application/screens/user_screen/user_screen.dart';
import 'package:cydeva_lua_application/screens/wishlist_screen/wishlist_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => SigninBloc()),
        BlocProvider(create: (context) => MyAccountBloc()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
