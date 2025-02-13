import 'package:api/themar_screens/terms/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'cubit.dart';

class TermsView extends StatefulWidget {
  const TermsView({super.key});

  @override
  State<TermsView> createState() => _TermsViewState();
}

class _TermsViewState extends State<TermsView> {
  late TermsCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms"),
        centerTitle: true,
      ),
      body: BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          if (state is TermsLoadingStates) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TermsErrorStates) {
            return Text(state.message);
          } else if (state is TermsSuccessStates) {
            return HtmlWidget(state.list.terms);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
