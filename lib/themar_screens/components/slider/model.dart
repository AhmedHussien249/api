class SliderData {
  late final List<SlidersModel> list;
  late final String status;
  late final String message;

  SliderData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => SlidersModel.fromJson(e))
        .toList();
    status = json['status'] ?? "";
    message = json['message'] ?? "";
  }
}

class SlidersModel {
  late final int id;
  late final String image;

  SlidersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    image = json['media'] ?? "";
  }
}
