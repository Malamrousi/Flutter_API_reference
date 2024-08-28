


import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_repo.dart';
import '../users_models.dart';
import 'my_state.dart';

class MyCubit extends Cubit<MyState> {
  final MyRepo myRepo;
  MyCubit({required this.myRepo}) : super(MyInitial());

  emitGetAllUser() {
    myRepo
        .getAllUsersModelsRepo()
        .then((getUserList) => emit(GetAllUsers(allUserList: getUserList)));

  }

  emaitGetUserByIdDetiles(int idValue) {
    myRepo.getUserByIRepo(idValue).then(((getUserByIdList) =>
        emit(GetAllUsersById(userData: getUserByIdList))));
  }

  emitCreateNewUSER(UsersModels newUsers) {
    myRepo
        .createUser(newUsers)
        .then((value) => emit(CreateNewUser(newUser: value)));
  }
}
