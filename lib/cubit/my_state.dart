part of 'my_cubit.dart';

@immutable
sealed class MyState {}

final class MyInitial extends MyState {}

final class GetAllUsers extends MyState {
  final List<UsersModels> allUserList;

  GetAllUsers({
    required this.allUserList,
  });
}

final class GetAllUsersById extends MyState {
  final UsersModels userDetiels;

  GetAllUsersById({
    required this.userDetiels,
  });


}


  final class CreateNewUser extends MyState {
  final UsersModels newUser;

  CreateNewUser({
    required this.newUser,
  });
}