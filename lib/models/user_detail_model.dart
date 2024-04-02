import 'package:cydeva_lua_application/models/user_model.dart';

class UserDetailModel{
  final int statusCode;
  final String message;
  final UserModel? userModel;

  UserDetailModel({ this.statusCode = 0, this.message = '', this.userModel});

  factory UserDetailModel.fromJson(Map<String,dynamic> json){
    return UserDetailModel(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ??'',
      userModel: UserModel.fromJson(json['data'])
    );
  }
}