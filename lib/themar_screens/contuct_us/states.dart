class ContactUsStates {}

class SendContactUsSuccessStates extends ContactUsStates {
  final String message;

  SendContactUsSuccessStates({required this.message});
}

class SendContactUsErrorStates extends ContactUsStates {
  final String message;

  SendContactUsErrorStates({required this.message});
}

class SendContactUsLoadingStates extends ContactUsStates {}