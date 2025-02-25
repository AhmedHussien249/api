import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'cubit.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final cubit = GetIt.instance<CounterCubit>();

  @override
  Widget build(BuildContext context) {
    print("build");
    return BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Counter"),
              centerTitle: true,
            ),
            body: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      print("minus");
                      cubit.minus();
                    },
                  ),
                  Text("${cubit.counter}"),
                  IconButton(
                    icon: const Icon(Icons.add),
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
