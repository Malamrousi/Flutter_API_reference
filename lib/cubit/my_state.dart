import 'package:api_learn/users_models.dart';

sealed class MyState {}

final class MyInitial extends MyState {}

final class GetAllUsers extends MyState {
  final List<UsersModels> allUserList;

  GetAllUsers({
    required this.allUserList,
  });
}

final class GetAllUsersById extends MyState {
final UsersModels userData;
  GetAllUsersById({
    required this.userData,
  });


}
  final class CreateNewUser extends MyState {
  final UsersModels newUser;

  CreateNewUser({
    required this.newUser,
  });
}

