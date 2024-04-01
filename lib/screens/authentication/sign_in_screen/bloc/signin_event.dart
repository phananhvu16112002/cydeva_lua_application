part of 'signin_bloc.dart';

class SigninEvent {}

class SignInSubmitted extends SigninEvent {
  SignInSubmitted();
}

class InforUserChanged extends SigninEvent {
  UserDetail? userDetail;

  InforUserChanged({this.userDetail});
}


