// import 'package:cydeva_lua_application/common/bases/custom_text.dart';
// import 'package:cydeva_lua_application/common/colors/Colors.dart';
// import 'package:cydeva_lua_application/screens/authentication/sign_in_screen/bloc/signin_bloc.dart';
// import 'package:cydeva_lua_application/screens/test_screen/test_screen_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({super.key});

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: BlocBuilder<TestScreenBloc, TestScreenState>(
//         builder: (context, state) {
//           return Center(
//             child: ElevatedButton(onPressed: () {
//               context.read<TestScreenBloc>().add(UserModelChanged());
//             }, child: const Text('Click')),
//           );
//         },
//       ),
//     );
//   }
// }
