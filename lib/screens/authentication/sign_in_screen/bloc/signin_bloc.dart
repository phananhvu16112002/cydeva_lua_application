import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cydeva_lua_application/models/social_auth_model/social_model.dart';
import 'package:cydeva_lua_application/models/user.dart';
import 'package:cydeva_lua_application/services/api.dart';
import 'package:cydeva_lua_application/utils/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninState()) {
    on<InforUserChanged>(_inforUserChanged);
    on<SignInSubmitted>(_onSignInSubmitted);
  }

  FutureOr<void> _inforUserChanged(
      InforUserChanged event, Emitter<SigninState> emit) {
    emit(state.copyWith(userDetail: event.userDetail));
  }

  FutureOr<void> _onSignInSubmitted(
      SignInSubmitted event, Emitter<SigninState> emit) async {
    try {
      var user = await signInWithGoogle();

      if (user.user != null) {
        emit(state.copyWith(
            status: BaseStatus.success, message: 'Sigin google successfully'));
        add(InforUserChanged(
            userDetail: UserDetail(
                imgPath: user.user!.photoURL ?? "",
                name: user.user!.displayName ?? '',
                email: user.user!.email ?? '')));
      } else {
        emit(state.copyWith(
            status: BaseStatus.failed, message: 'Sigin google failed'));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // SecureStorage secureStorage = SecureStorage();
    final APIService apiService =
        APIService(Dio(BaseOptions(contentType: 'application/json')));
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print('check :${googleAuth!.idToken}');
    if (googleAuth.idToken != null || googleAuth.idToken != '') {
      sharedPreferences.setString('tokenGoogle', googleAuth.idToken!);
      // print('Write data successfully');
    }
    var value = await FirebaseAuth.instance.signInWithCredential(credential);
    var accessToken = sharedPreferences.getString('tokenGoogle');
    Map<String, dynamic> postData = {
      'token': accessToken,
      'provider': 'google',
      'device_id': '1234'
    };
    var response = apiService.socialAuth(postData);
    print('response: ${response}');
    response.then((value) {
      print(value.data!['token']);
      sharedPreferences.setString('accessToken', value.data!['token']);
    });
    // GoogleSignIn().signOut();
    return value;
  }

  Future<void> _signOut() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return _firebaseAuth.signOut();
  }
}
