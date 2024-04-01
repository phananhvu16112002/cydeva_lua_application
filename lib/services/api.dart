import 'package:cydeva_lua_application/models/favorite_response.dart';
import 'package:cydeva_lua_application/models/model_test.dart';
import 'package:cydeva_lua_application/models/response_model.dart';
import 'package:cydeva_lua_application/models/social_auth_model/social_model.dart';
import 'package:cydeva_lua_application/models/user_model.dart';
import 'package:cydeva_lua_application/utils/constants.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

@RestApi(baseUrl: Constants.baseURl)
abstract class APIService {
  factory APIService(Dio dio, {String baseUrl}) = _APIService;

  @POST('/api/v1/auth/mb/login/social/')
  Future<SocialModel> socialAuth(@Body() Map<String, dynamic> mapData);

  @GET('/api/v1/auth/mb/user/detail/')
  Future<ResponseModel> getUserDetail();

  @PUT('/api/v1/auth/mb/user/update/')
  // @Header('multipart/form-data')
  Future<ResponseModel> updateInfoUser(@Body() FormData mapData);

  @GET('/api/v1/auth/mb/user/favorite/content/list/')
  Future<ResponseFavorite> getFavoriteList();

  @POST('/api/v1/auth/mb/user/favorite/content/update/')
  Future<ModelTest> updateFavoriteList(
      @Body() Map<String, dynamic> mapJson);
}
