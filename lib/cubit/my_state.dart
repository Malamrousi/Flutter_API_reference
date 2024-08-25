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
