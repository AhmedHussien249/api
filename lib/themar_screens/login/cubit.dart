import 'dart:io';

import 'package:api/core/logic/dio_helper.dart';
import 'package:api/themar_screens/login/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/helper.dart';
import '../view.dart';

class LoginCubit extends Cubit<LoginStates> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  final DioHelper _dio;

  LoginCubit(this._dio) : super(LoginStates());

  Future<void> send(context) async {
    emit(LoginLoadingStates());
    final response = await _dio.send("login", data: {
      "phone": phoneController.text,
      "password": passwordController.text,
      "device_token": "test",
      "type": Platform.operatingSystem,
      "user_type": "client"
    });
    print(response.data);
    if (response.isSuccess) {
      navigateTo(Views(), isReplacement: true, keepHistory: false);
      emit(LoginSuccessStates());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message!),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      emit(LoginFailedStates());
    }
    // isLoading = false;
    // setState(() {});
  }
}
