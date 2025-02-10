import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late CounterCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Counter"),
              centerTitle: true,
            ),
            body: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      print("minus");
                      cubit.minus();
                    },
                  ),
                  Text("${cubit.counter}"),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      cubit.plus();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
