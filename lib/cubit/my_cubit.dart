import 'package:api_learn/my_repo.dart';
import 'package:api_learn/users_models.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_state.dart';

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
        emit(GetAllUsersById(userDetiels: getUserByIdList))));
  }
}
