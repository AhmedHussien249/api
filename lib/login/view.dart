import 'package:api/core/designs/app_input.dart';
import 'package:api/login/cubit.dart';
import 'package:api/login/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/designs/app_button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Builder(builder: (context) {
        LoginCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppInput(
                    label: "phone",
                    controller: cubit.phoneController,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AppInput(
                    label: "password",
                    isPassword: true,
                    controller: cubit.passwordController,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BlocBuilder(
                      bloc: cubit,
                      builder: (context, state) {
                        if (state is LoginLoadingStates) {
                          return CircularProgressIndicator();
                        } else {
                          return AppButton(
                            text: "تسجيل الدخول",
                            onPressed: () {
                              cubit.send(context);
                            },
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
