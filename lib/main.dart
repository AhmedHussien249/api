import 'package:api/core/logic/helper.dart';
import 'package:api/questions/view.dart';
import 'package:api/themar_screens/components/category_section/cubit.dart';
import 'package:api/themar_screens/components/products/cubit.dart';
import 'package:api/themar_screens/components/slider/cubit.dart';
import 'package:api/themar_screens/contuct_us/view.dart';
import 'package:api/themar_screens/login/cubit.dart';
import 'package:api/themar_screens/terms/cubit.dart';
import 'package:api/themar_screens/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter/cubit.dart';
import 'themar_screens/contuct_us/cubit.dart';

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
        BlocProvider(create: (context) => ContactUsCubit()),
        BlocProvider(create: (context) => CategoriesCubit()..getData()),
        BlocProvider(create: (context) => ProductsCubit()..getData()),
        BlocProvider(create: (context) => SliderCubit()..getData()),
        BlocProvider(create: (context) => TermsCubit()..getData()),
      ],
      child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: const QuestionsView()),
    );
  }
}
