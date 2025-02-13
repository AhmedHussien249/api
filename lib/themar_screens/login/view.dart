import 'package:api/core/designs/app_input.dart';
import 'package:api/themar_screens/login/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/designs/app_button.dart';
import 'cubit.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
