import 'package:bloc/bloc.dart';

import '../models/user.dart';

part 'listofuserhorisaltal_state.dart';

class ListofuserhorisaltalCubit extends Cubit<ListofuserhorisaltalState> {
  ListofuserhorisaltalCubit() : super(ListofuserhorisaltalState(listFavorite: []));

  addFavoritUser(List<User> list) {
    list.sort();
    emit(ListofuserhorisaltalState(listFavorite: list));
  }

  removeUser(List<User> list) {
    list.sort();

    emit(ListofuserhorisaltalState(listFavorite: list));
  }

  updateUser(List<User> list, User old, User user) async {
    emit(ListofuserhorisaltalState(listFavorite: list));
    await Future.delayed(Duration(seconds: 3));
    list.remove(old);
    list.add(user);

    emit(ListofuserhorisaltalState(
      listFavorite: list,
    ));
  }
}
