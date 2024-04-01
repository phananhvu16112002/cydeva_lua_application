import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cydeva_lua_application/models/user_model.dart';
import 'package:cydeva_lua_application/services/api.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
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
      SaveInforUser event, Emitter<MyAccountState> emit) {}

  FutureOr<void> _onInforUserInitial(
      InforUserInitial event, Emitter<MyAccountState> emit) async {
    print('Alo ALo go go');
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
              userModel: state.userModel));
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
