import 'package:bloc_app/cubit/listofuser_cubit.dart';
import 'package:bloc_app/cubit/listofuserhorisaltal_cubit.dart';
import 'package:bloc_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ListofuserCubit(context: context),
        ),
        BlocProvider(
          create: (context) => ListofuserhorisaltalCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}
