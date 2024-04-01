part of 'register_bloc.dart';

class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  String phoneNumber = '';
  String fullName = '';
  String gender = '';
  String address = '';
  XFile? xFile;
  RegisterSubmitted(
      {required this.phoneNumber,
      required this.fullName,
      required this.gender,
      required this.address,
      required this.xFile});
}

class InfoUserChangeRegister extends RegisterEvent {
  UserModel? userModel;
  InfoUserChangeRegister(this.userModel);
}
