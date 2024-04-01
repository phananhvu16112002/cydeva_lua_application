part of 'my_account_bloc.dart';

class MyAccountEvent {}

class InforUserInitial extends MyAccountEvent{
  UserModel? userModel;
  InforUserInitial({this.userModel});
}

class InforChanged extends MyAccountEvent {
  UserModel? userModel;
  InforChanged({this.userModel});
}

class SaveInforUser extends MyAccountEvent {
  UserModel? userModel;
  SaveInforUser({this.userModel});
}
