import 'package:api/core/logic/helper.dart';
import 'package:api/counter/view.dart';
import 'package:api/themar_screens/components/category_section/cubit.dart';
import 'package:api/themar_screens/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter/cubit.dart';
import 'login/cubit.dart';
import 'login/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => CategoriesCubit()..getData()),

      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const Login()
      ),
    );
  }
}

/* state Mangement (statelful - cubit-bloc-provider-getx-redux)
1. separate ui and logic
2. handle code into pieces
3.handle when refresh just refresh the need part
 */