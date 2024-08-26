import 'package:flutter/material.dart';
import 'package:api_learn/users_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/my_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UsersModels> usersList = [];
  late UsersModels usersModelsDetiels;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<MyCubit>(context).emitCreateNewUSER(UsersModels(
        id: 45750256,
        name: 'Kayn Mohammed Al-amrousi',
        email: 'keyanmohammed@gmai.com',
        gender: 'famle',
        status: 'inactive'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: Column(
        children: [
          BlocBuilder<MyCubit, MyState>(builder: (context, state) {
            if (state is CreateNewUser) {
              // هنا يتم جلب التفاصيل الخاصة بالمستخدم من خلال state
              UsersModels usersModelsDetiels = state.newUser;
              return Container(
                height: 50,
                child: Center(
                  child: Text(usersModelsDetiels.name.toString()),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ],
      ),
    );
  }
}
// BlocBuilder<MyCubit, MyState>(builder: (context, state) {
//   if (state is GetAllUsers) {
//     usersList = (state).allUserList;
//     return ListView.builder(
//       shrinkWrap: true,
//       padding: const EdgeInsets.all(8),

//       itemCount: usersList.length,
//       itemBuilder: (context, int index) {

//       return Container(
//         height: 50,
//         child: Center(
//           child: Text(usersList[index].name.toString()),
//         ),
//       );
//     });
//   } else {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// })
