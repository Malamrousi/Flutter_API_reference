import 'package:api_learn/users_models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'web_services.g.dart';

@RestApi(baseUrl: 'https://gorest.co.in/public/v2/')
abstract class WebServices {
  factory WebServices(Dio dio, {String baseUrl}) = _WebServices;

  @GET('users')
  Future<List<UsersModels>> getAllUsersModels();
}
