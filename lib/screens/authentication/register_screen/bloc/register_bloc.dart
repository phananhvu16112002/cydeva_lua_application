import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cydeva_lua_application/models/user_model.dart';
import 'package:cydeva_lua_application/services/api.dart';
import 'package:cydeva_lua_application/utils/secure_storage.dart';
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
    SecureStorage secureStorage = SecureStorage();
    try {
      final apiService = APIService(
        Dio(BaseOptions(
          contentType: 'multipart/form-data',
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        )),
      );
      if (event.xFile != null &&
          event.phoneNumber.isNotEmpty &&
          event.fullName.isNotEmpty &&
          event.gender.isNotEmpty &&
          event.address.isNotEmpty) {
        Map<String, dynamic> data = {
          "phone_number": event.phoneNumber,
          "full_name": event.fullName,
          "gender": event.gender,
          "address": event.address,
          "avatar": await MultipartFile.fromFile(event.xFile!.path) ?? ''
        };
        var formData = FormData.fromMap(data);
        await apiService.updateInfoUser(formData).then((value) async {
          if (value.statusCode == 200) {
            emit(state.copyWith(
                status: BasesStatus.success,
                message: value.message,
                userModel: value.userModel));
            await secureStorage.writeSecureData('phone_number', value.userModel!.phoneNumber! );
            await secureStorage.writeSecureData('full_name', value.userModel!.fullName! );
            await secureStorage.writeSecureData('address', value.userModel!.address! );
            await secureStorage.writeSecureData('url', value.userModel!.avatar! );



          } else {
            print(' aloas da');
            emit(state.copyWith(
                status: BasesStatus.failed, message: state.message));
          }
        });
      } 
      else {
        emit(state.copyWith(status: BasesStatus.failedSubmitted, message: 'Check your information'));
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}


// else {
//         Map<String, dynamic> data = {
//           "phone_number": event.phoneNumber,
//           "full_name": event.fullName,
//           "gender": event.gender,
//           "address": event.address,
//         };
//         var formData = FormData.fromMap(data);
//         await apiService.updateInfoUser(formData).then((value) {
//           if (value.statusCode == 200) {
//             emit(state.copyWith(
//                 status: BasesStatus.success,
//                 message: state.message,
//                 userModel: state.userModel));
//           } else {
//             emit(state.copyWith(
//                 status: BasesStatus.failed, message: state.message));
//           }
//         });
//       }
