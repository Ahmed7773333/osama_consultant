class AddSlotModel {
  bool? success;
  Data? data;
  String? message;

  AddSlotModel({this.success, this.data, this.message});

  AddSlotModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  int? scheduleId;
  String? from;
  String? to;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.scheduleId,
      this.from,
      this.to,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    scheduleId = json['schedule_id'];
    from = json['from'];
    to = json['to'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}

class SlotToAdd {
  int id;
  String from;
  String to;
  SlotToAdd(this.id, this.from, this.to);
  Map<String, dynamic> toMap() {
    return {
      'schedule_id': id,
      'from': from,
      'to': to,
    };
  }
}
