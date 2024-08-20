class StoreConsultantModel {
  bool? success;
  Data? data;
  String? message;

  StoreConsultantModel({this.success, this.data, this.message});

  StoreConsultantModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  int? consultantsCount;

  Data({this.consultantsCount});

  Data.fromJson(Map<String, dynamic> json) {
    consultantsCount = json['consultants_count'];
  }
}
