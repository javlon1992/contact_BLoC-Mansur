import 'dart:async';
import 'package:bloc_app/cubit/listofuserhorisaltal_cubit.dart';
import 'package:bloc_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'listofuser_state.dart';

class ListofuserCubit extends Cubit<ListofuserState> {
  BuildContext context;
  ListofuserCubit({
    required this.context,
  }) : super(ListofuserState(list: [
          User(name: "Mansur", phoneNumber: "+998999415835"),
          User(name: "Mansur1", phoneNumber: "+998999415835"),
          User(name: "Mansur2", phoneNumber: "+998999415835"),
        ], isLoading: false)) {
    // internetCubit.onChange((){})
  }

  addUser(List<User> list, User user) async {
    emit(ListofuserState(list: list, isLoading: true));
    await Future.delayed(const Duration(seconds: 3));
    list.add(user);

    emit(ListofuserState(list: list, isLoading: false));
  }

  updateUser(List<User> list, User old, User user) async {
    emit(ListofuserState(list: list, isLoading: true));
    await Future.delayed(Duration(seconds: 3));
    list.remove(old);
    list.add(user);
    list.sort();

    emit(ListofuserState(list: list, isLoading: false));
  }

  deleteUser(List<User> list, User user) async {
    emit(ListofuserState(list: list, isLoading: true));
    await Future.delayed(Duration(seconds: 3));
    list.remove(user);

    emit(ListofuserState(list: list, isLoading: false));
  }

  sortUsers(List<User> list) {
    list.sort();
    emit(ListofuserState(list: list));
  }

  ff(BuildContext context, User user, List<User> list, [List<User>? listF]) {
    TextEditingController _name = TextEditingController(text: user.name);
    TextEditingController _phoneNumber =
        TextEditingController(text: user.phoneNumber);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return DraggableScrollableSheet(
            maxChildSize: 0.9,
            minChildSize: 0.7,
            initialChildSize: 0.7,
            builder: (context, scrollController) => Container(
              padding: EdgeInsets.all(15),
              height: 700,
              color: Colors.white,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _name,
                      decoration: InputDecoration(helperText: "Edit name"),
                    ),
                    TextField(
                        controller: _phoneNumber,
                        decoration:
                            InputDecoration(helperText: "Edit phone number")),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<ListofuserhorisaltalCubit,
                        ListofuserhorisaltalState>(
                      builder: (context, state) {
                        return MaterialButton(
                          onPressed: () {
                            updateUser(
                                list,
                                user,
                                User(
                                    name: _name.text,
                                    phoneNumber: _phoneNumber.text,
                                    isFovorite:
                                        user.isFovorite ? true : false));

                            if (listF != null) {
                              BlocProvider.of<ListofuserhorisaltalCubit>(
                                      context)
                                  .updateUser(
                                      listF,
                                      user,
                                      User(
                                          name: _name.text,
                                          phoneNumber: _phoneNumber.text,
                                          isFovorite: true));
                            }

                            Navigator.pop(context);
                          },
                          color: Colors.blueAccent,
                          height: 50,
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 300,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  dialog(
    context,
    User user,
    List<User> list,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete commen"),
            content: Text("Are you deleting??"),
            actions: [
              BlocBuilder<ListofuserhorisaltalCubit, ListofuserhorisaltalState>(
                builder: (context, state) {
                  return TextButton(
                      onPressed: () {
                        deleteUser(list, user);
                        state.listFavorite.remove(user);
                        BlocProvider.of<ListofuserhorisaltalCubit>(context)
                            .removeUser(state.listFavorite);
                        Navigator.pop(context);
                      },
                      child: Text("Delete"));
                },
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close")),
            ],
          );
        });
  }

  showBottomSh(BuildContext context, List<User> list) {
    TextEditingController _name = TextEditingController();
    TextEditingController _phoneNumber = TextEditingController();
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return DraggableScrollableSheet(
            maxChildSize: 0.9,
            minChildSize: 0.7,
            initialChildSize: 0.7,
            builder: (context, scrollController) => Container(
              height: MediaQuery.of(context).size.height - 200,
              padding: EdgeInsets.all(15),
              color: Colors.white,
              child: SingleChildScrollView(
                controller: scrollController,
                // physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _name,
                      decoration: InputDecoration(helperText: "Name"),
                    ),
                    TextField(
                        controller: _phoneNumber,
                        decoration:
                            InputDecoration(helperText: "Phone number")),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        addUser(
                            list,
                            User(
                                name: _name.text,
                                phoneNumber: _phoneNumber.text));
                        Navigator.pop(context);
                      },
                      color: Colors.blueAccent,
                      height: 50,
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
