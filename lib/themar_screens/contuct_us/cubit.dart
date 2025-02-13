import 'package:api/themar_screens/contuct_us/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';

class ContactUsCubit extends Cubit<ContactUsStates> {
  ContactUsCubit() : super(ContactUsStates());
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  Future<void> send() async {
    emit(SendContactUsLoadingStates());
    final response = await DioHelper.send("contact", data: {
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
