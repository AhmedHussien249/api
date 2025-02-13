import 'model.dart';

class TermsStates {}

class TermsLoadingStates extends TermsStates {}

class TermsSuccessStates extends TermsStates {
  final TermsModel list;

  TermsSuccessStates({required this.list});
}

class TermsErrorStates extends TermsStates {
  final String message;

  TermsErrorStates({required this.message});
}
