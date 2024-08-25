// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:api_learn/web_services.dart';

import 'users_models.dart';

class MyRepo {
  WebServices webServices;
  MyRepo({
    required this.webServices,
  });

  Future<UsersModels> getAllUsersModelsRepo() async {
    var response = await webServices.getAllUsersSrevices();

    return response;
  }
}


    // return response.map((e)=>UsersModels.fromJson(e.toJson())).toList();
