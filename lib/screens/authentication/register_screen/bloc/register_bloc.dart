import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cydeva_lua_application/models/user_model.dart';
import 'package:cydeva_lua_application/services/api.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<InfoUserChangeRegister>(_inforUserChanged);
    on<RegisterSubmitted>(_onRegisterSubmmitted);
  }

  FutureOr<void> _inforUserChanged(
      InfoUserChangeRegister event, Emitter<RegisterState> emit) {
    emit(state.copyWith(userModel: event.userModel));
  }

  FutureOr<void> _onRegisterSubmmitted(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var accessToken = sharedPreferences.getString('accessToken');
    try {
      final apiService = APIService(
        Dio(BaseOptions(
          contentType: 'multipart/form-data',
          headers: {
            'Authorization': 'Bearer $accessToken',
            // 'Content-Type':'multipart/form-data'
            // 'Content-Type': 'application/json',
          },
        )),
      );
      if (event.xFile != null) {
        Map<String, dynamic> data = {
          "phone_number": event.phoneNumber,
          "full_name": event.fullName,
          "gender": event.gender,
          "address": event.address,
          "avatar": await MultipartFile.fromFile(event.xFile!.path)
        };
        var formData = FormData.fromMap(data);
        await apiService.updateInfoUser(formData).then((value) {
          if (value.statusCode == 200) {
            emit(state.copyWith(
                status: BasesStatus.success,
                message: state.message,
                userModel: state.userModel));
          } else {
            emit(state.copyWith(
                status: BasesStatus.failed, message: state.message));
          }
        });
      } else {
        Map<String, dynamic> data = {
          "phone_number": event.phoneNumber,
          "full_name": event.fullName,
          "gender": event.gender,
          "address": event.address,
          // "avatar": 
        };
        var formData = FormData.fromMap(data);
        await apiService.updateInfoUser(formData).then((value) {
          if (value.statusCode == 200) {
            emit(state.copyWith(
                status: BasesStatus.success,
                message: state.message,
                userModel: state.userModel));
          } else {
            emit(state.copyWith(
                status: BasesStatus.failed, message: state.message));
          }
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
