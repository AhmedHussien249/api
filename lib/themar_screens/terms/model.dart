class TermsData {
  late final TermsModel list;
  late final String status;
  late final String message;

  TermsData.fromJson(Map<String, dynamic> json) {
    list = TermsModel.fromJson(json['data'] ?? {});
    status = json['status'] ?? "";
    message = json['message'] ?? "";
  }
}

class TermsModel {
  late final String terms;

  TermsModel.fromJson(Map<String, dynamic> json) {
    terms = json['terms'] ?? "";
  }
}
