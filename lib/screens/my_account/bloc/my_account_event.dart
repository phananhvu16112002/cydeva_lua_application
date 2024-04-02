part of 'my_account_bloc.dart';

class MyAccountEvent {}

class InforUserInitial extends MyAccountEvent {
  UserModel? userModel;
  InforUserInitial({this.userModel});
}

class InforChanged extends MyAccountEvent {
  UserModel? userModel;
  InforChanged({this.userModel});
}

class SaveInforUser extends MyAccountEvent {
  String phoneNumber = '';
  String fullName = '';
  String gender = '';
  String address = '';
  XFile? xFile;
  SaveInforUser(
      {required this.phoneNumber,
      required this.fullName,
      required this.gender,
      required this.address,
      required this.xFile});
}
