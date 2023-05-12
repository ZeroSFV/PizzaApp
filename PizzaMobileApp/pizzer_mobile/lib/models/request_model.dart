class RequestModel {
  int? status;
  String? description;

  RequestModel({this.status, this.description});

  RequestModel.fromJson(dynamic json) {
    status = json['status'];
    description = json['description'];
  }
}
