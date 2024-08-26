// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:api_learn/web_services.dart';

import 'users_models.dart';

class MyRepo {
  WebServices webServices;
  MyRepo({
    required this.webServices,
  });

  Future<List<UsersModels>> getAllUsersModelsRepo() async {
    var response = await webServices.getAllUsersSrevices();

    return response.map((e) => UsersModels.fromJson(e.toJson())).toList();
  }

  Future<UsersModels> getUserByIRepo(int userId) async {
    var response = await webServices.getUserById(userId);

    return UsersModels.fromJson(response.toJson());
  }

  Future<UsersModels> createUser(UsersModels newUseer) async {
    return await webServices.postUser(newUseer, 'Bearer b33876c9f86939d0d1bb4fda3f5973092cce99e9cddd3a4f03320a7cd04e3144	');
  }
}


    // return response.map((e)=>UsersModels.fromJson(e.toJson())).toList();
