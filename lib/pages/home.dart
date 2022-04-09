import 'package:bloc_app/cubit/listofuser_cubit.dart';
import 'package:bloc_app/cubit/listofuserhorisaltal_cubit.dart';
import 'package:bloc_app/pages/count_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListofuserCubit, ListofuserState>(
      builder: (context, state) {
        ListofuserCubit listofuserCubit = BlocProvider.of<ListofuserCubit>(context);

        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: const Text("BloC pattern", style: TextStyle(color: Colors.black),),
              ),
              body: BlocBuilder<ListofuserhorisaltalCubit, ListofuserhorisaltalState>(
                builder: (context, stateF) {
                  ListofuserhorisaltalCubit listofuserhorisaltalCubit = BlocProvider.of<ListofuserhorisaltalCubit>(context);

                  return ListView(children: [
                    stateF.listFavorite.isNotEmpty
                        ? Container(
                            height: 76,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                  stateF.listFavorite.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        child: Text(
                                          stateF.listFavorite[index].name[0],
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Text(stateF.listFavorite[index].name)
                                    ],
                                  ),
                                );
                              }),
                            ),
                          )
                        : const SizedBox.shrink(),
                    ...List.generate(state.list.length, (index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              // backgroundColor: listColor[Random().nextInt(6)],
                              child: Text(
                                state.list[index].name[0],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(state.list[index].name),
                            subtitle: Text(state.list[index].phoneNumber),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      listofuserCubit.dialog(
                                        context,
                                        state.list[index],
                                        state.list,
                                      );
                                    },
                                    icon: const Icon(Icons.delete, color: Colors.red,)),
                                IconButton(
                                    onPressed: () {
                                      listofuserCubit.ff(
                                          context,
                                          state.list[index],
                                          state.list,
                                          stateF.listFavorite);
                                    },
                                    icon: const Icon(Icons.mode_edit_rounded, color: Colors.blueAccent,)),
                                IconButton(
                                    onPressed: () {
                                      state.list[index].isFovorite = !state.list[index].isFovorite;

                                      if (state.list[index].isFovorite) {
                                        stateF.listFavorite.add(state.list[index]);

                                        listofuserhorisaltalCubit.addFavoritUser(stateF.listFavorite);
                                      } else {
                                        stateF.listFavorite.remove(state.list[index]);

                                        listofuserhorisaltalCubit.addFavoritUser(stateF.listFavorite);
                                      }

                                      listofuserCubit.sortUsers(state.list);
                                    },
                                    icon: Icon(
                                        state.list[index].isFovorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.yellowAccent.shade700)),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            height: 4,
                            color: Colors.grey.shade200,
                          )
                        ],
                      );
                    }),
                  ]);
                },
              ),
              floatingActionButton:
                  BlocBuilder<ListofuserCubit, ListofuserState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          listofuserCubit.showBottomSh(context, state.list);
                        },
                        child: Icon(Icons.add),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) {
                            return CountPage();
                          }));
                        },
                        child: Icon(Icons.next_plan_outlined),
                      ),
                    ],
                  );
                },
              ),
            ),
            state.isLoading
                ? Container(
                    color: Colors.black26,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),)
                : const SizedBox.shrink()
          ],
        );
      },
    );
  }
}
