import 'package:cydeva_lua_application/models/user_model.dart';

class ResponseModel{
  final int statusCode;
  final String message;
  final UserModel? userModel;

  ResponseModel({ this.statusCode = 0, this.message = '', this.userModel});

  factory ResponseModel.fromJson(Map<String,dynamic> json){
    return ResponseModel(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ??'',
      userModel: UserModel.fromJson(json)
    );
  }
}