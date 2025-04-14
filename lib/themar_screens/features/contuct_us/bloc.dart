import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import 'events.dart';
import 'states.dart';

class ContactUsBloc extends Bloc<ContactUsEvents, ContactUsStates> {
  final DioHelper _dio;

  ContactUsBloc(this._dio) : super(ContactUsStates()) {
    on<ContactUsSendEvent>(_send);
  }

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  Future<void> _send(
      ContactUsSendEvent event, Emitter<ContactUsStates> emit) async {
    emit(SendContactUsLoadingStates());
    final response = await _dio.send("contact", data: {
      "fullname": fullNameController.text,
      "phone": phoneController.text,
      "title": titleController.text,
      "content": contentController.text,
    });
    if (response.isSuccess) {
      emit(SendContactUsSuccessStates(message: "success"));
    } else {
      emit(SendContactUsErrorStates(message: response.message ?? ""));
    }
  }
}
