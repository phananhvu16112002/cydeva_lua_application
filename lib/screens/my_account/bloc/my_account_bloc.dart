import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cydeva_lua_application/models/user_model.dart';
import 'package:cydeva_lua_application/services/api.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'my_account_event.dart';
part 'my_account_state.dart';

class MyAccountBloc extends Bloc<MyAccountEvent, MyAccountState> {
  MyAccountBloc() : super(MyAccountState()) {
    on<InforUserInitial>(_onInforUserInitial);
    on<InforChanged>(_onInforChanged);
    on<SaveInforUser>(_onSaveInforUser);
  }

  FutureOr<void> _onInforChanged(
      InforChanged event, Emitter<MyAccountState> emit) {
    emit(state.copyWith(userModel: event.userModel));
  }

  FutureOr<void> _onSaveInforUser(
      SaveInforUser event, Emitter<MyAccountState> emit) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var accessToken = sharedPreferences.getString('accessToken');
    try {
      final apiService = APIService(
        Dio(BaseOptions(
          contentType: 'multipart/form-data',
          headers: {
            'Authorization': 'Bearer $accessToken',
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
                status: AccountStatus.submittedSuccess,
                message: state.message,
                userModel: state.userModel));
          } else {
            emit(state.copyWith(
                status: AccountStatus.failed, message: state.message));
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
                status: AccountStatus.submittedSuccess,
                message: state.message,
                userModel: state.userModel));
          } else {
            emit(state.copyWith(
                status: AccountStatus.failed, message: state.message));
          }
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  FutureOr<void> _onInforUserInitial(
      InforUserInitial event, Emitter<MyAccountState> emit) async {
    emit(state.copyWith(status: AccountStatus.loading));
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var accessToken = sharedPreferences.getString('accessToken');
    try {
      final apiService = APIService(
          Dio(BaseOptions(headers: {'Authorization': 'Bearer $accessToken'})));
      await apiService.getUserDetail().then((value) {
        print('Ok');
        if (value.statusCode == 200) {
          emit(state.copyWith(
              status: AccountStatus.success,
              // message: state.message,
              userModel: value.userModel));
        } else {
          emit(state.copyWith(
              status: AccountStatus.failed, message: state.message));
        }
      });
    } catch (e) {
      print('Err:$e');
    }
  }
}
