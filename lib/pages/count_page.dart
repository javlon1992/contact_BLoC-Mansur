import 'package:bloc_app/cubit/listofuser_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountPage extends StatefulWidget {
  const CountPage({Key? key}) : super(key: key);

  @override
  State<CountPage> createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListofuserCubit, ListofuserState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.black,)),
                backgroundColor: Colors.white,
                title: const Text("BloC pattern", style: TextStyle(color: Colors.black),),
              ),
              body: BlocBuilder<ListofuserCubit, ListofuserState>(
                builder: (context, state) {
                  return ListView(
                    children: List.generate(state.list.length, (index) {
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
                                      BlocProvider.of<ListofuserCubit>(context)
                                          .dialog(context, state.list[index],
                                              state.list);
                                    },
                                    icon: const Icon(Icons.delete, color: Colors.red,)),
                                IconButton(
                                    onPressed: () {
                                      BlocProvider.of<ListofuserCubit>(context)
                                          .ff(context, state.list[index],
                                              state.list);
                                    },
                                    icon: const Icon(Icons.mode_edit_rounded, color: Colors.blueAccent,)),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            height: 4,
                            color: Colors.grey.shade200,
                          )
                        ],
                      );
                    }),
                  );
                },
              ),
              floatingActionButton:
                  BlocBuilder<ListofuserCubit, ListofuserState>(
                builder: (context, state) {
                  return FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<ListofuserCubit>(context)
                          .showBottomSh(context, state.list);
                    },
                    child: Icon(Icons.add),
                  );
                },
              ),
            ),
            state.isLoading
                ? Container(
                    color: Colors.black26,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
                : const SizedBox.shrink()
          ],
        );
      },
    );
  }
}
