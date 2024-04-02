import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cydeva_lua_application/models/favorite_model.dart';
import 'package:cydeva_lua_application/services/api.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistState()) {
    on<ListFavoriteInitital>(_onListFavoriteInitial);
    on<ListFavoriteChanged>(_onListFavoriteChanged);
    on<SubmitFavorite>(_onSubmitFavorite);
    on<ListFavoriteChoosen>(_onListFavoriteChoosen);
  }

  FutureOr<void> _onListFavoriteInitial(
      ListFavoriteInitital event, Emitter<WishlistState> emit) async {
    emit(state.copyWith(
      status: WishlistStatus.loading,
      // listData: value.listFavoriteCategory,
    ));
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var accessToken = sharedPreferences.getString('accessToken');
    final apiService = APIService(Dio(BaseOptions(
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    )));
    await apiService.getFavoriteList().then((value) {
      if (value.statusCode == 200) {
        emit(state.copyWith(
          status: WishlistStatus.success,
          listData: value.listFavoriteCategory,
        ));
      } else {
        emit(state.copyWith(
            status: WishlistStatus.failed, message: value.message));
      }
    });
  }

  FutureOr<void> _onListFavoriteChanged(
      ListFavoriteChanged event, Emitter<WishlistState> emit) {
    List<FavoriteCategory> listTemp = List.from(state.listSelectedData ?? []);
    if (listTemp.contains(event.listData)) {
      listTemp.remove(event.listData);
    } else {
      listTemp.add(event.listData!);
    }
    emit(state.copyWith(listSelectedData: listTemp));
  }

  FutureOr<void> _onSubmitFavorite(
      SubmitFavorite event, Emitter<WishlistState> emit) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var accessToken = sharedPreferences.getString('accessToken');
    List<String> listTemp = [];
    final apiService = APIService(Dio(BaseOptions(
      contentType: 'application/json',
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    )));
    for (var i = 0; i < event.listData!.length; i++) {
      listTemp.add(event.listData![i].title!);
    }
    Map<String, dynamic> data = {'favorite_content': listTemp};
    await apiService.updateFavoriteList(data).then((value) {
      if (value.status_code == 200) {
        emit(state.copyWith(
          status: WishlistStatus.submittedSuccess,
        ));
      } else {
        emit(state.copyWith(
            status: WishlistStatus.failed, message: value.message));
      }
    });
  }

  FutureOr<void> _onListFavoriteChoosen(
      ListFavoriteChoosen event, Emitter<WishlistState> emit) async {
    emit(state.copyWith(status: WishlistStatus.loading));
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var accessToken = sharedPreferences.getString('accessToken');
    List<FavoriteCategory> listTemp = [];
    try {
      final apiService = APIService(
          Dio(BaseOptions(headers: {'Authorization': 'Bearer $accessToken'})));
      await apiService.getUserDetail().then((value) {
        print('Ok');
        if (value.statusCode == 200) {
          for (var i = 0; i < value.userModel!.favContent!.length; i++) {
            listTemp
                .add(FavoriteCategory(title: value.userModel!.favContent![i]));
          }
          emit(state.copyWith(
              status: WishlistStatus.success,
              // message: state.message,
              listSelectedData: listTemp));
        } else {
          emit(state.copyWith(
              status: WishlistStatus.failed, message: state.message));
        }
      });
    } catch (e) {
      print('Err:$e');
    }
  }
}
