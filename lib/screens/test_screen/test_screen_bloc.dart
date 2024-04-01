// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:cydeva_lua_application/models/user_model.dart';
// import 'package:cydeva_lua_application/services/api.dart';
// import 'package:equatable/equatable.dart';
// import 'package:dio/dio.dart';

// part 'test_screen_event.dart';
// part 'test_screen_state.dart';

// class TestScreenBloc extends Bloc<TestScreenEvent, TestScreenState> {
//   TestScreenBloc() : super(TestScreenState()) {
//     on<UserModelChanged>(_onUserModelChanged);
//   }

//   FutureOr<void> _onUserModelChanged(
//       UserModelChanged event, Emitter<TestScreenState> emit) async {
//     print('ao alo');
//     try {
//       final apiService =
//           APIService(Dio(BaseOptions(contentType: 'application/json')));
//       UserModel? userModel = await apiService.getUserDetail();
//       print(userModel);
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }
