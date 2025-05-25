import 'package:api/core/designs/app_input.dart';
import 'package:api/core/logic/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'bloc.dart';
import 'events.dart';
import 'states.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final bloc = GetIt.instance<ContactUsBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Contact Us"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppInput(
                  controller: bloc.fullNameController,
                  label: "full name",
                  hint: "enter your full name",
                ),
                const SizedBox(
                  height: 16,
                ),
                AppInput(
                  controller: bloc.phoneController,
                  label: "phone",
                  hint: "enter your phone number",
                ),
                const SizedBox(
                  height: 16,
                ),
                AppInput(
                  controller: bloc.titleController,
                  label: "title",
                  hint: "enter your title",
                ),
                const SizedBox(
                  height: 16,
                ),
                AppInput(
                  controller: bloc.contentController,
                  label: "content",
                  hint: "enter your content",
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocConsumer(
                    bloc: bloc,
                    listener: (context, state) {
                      if (state is SendContactUsSuccessStates) {
                        print("*****");
                        print(state.message);
                        showMessage(state.message,
                            messageType: MessageType.success);
                      } else if (state is SendContactUsErrorStates) {
                        print("*****");
                        print(state.message);
                        showMessage(state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is SendContactUsLoadingStates) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return FilledButton(
                          onPressed: () {
                            bloc.add(ContactUsSendEvent());
                          },
                          child: const Text("send"),
                        );
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
