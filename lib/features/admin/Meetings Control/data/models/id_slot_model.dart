class IdSlotModel {
  bool? success;
  SlotIDModel? data;
  String? message;

  IdSlotModel({this.success, this.data, this.message});

  IdSlotModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? SlotIDModel.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class SlotIDModel {
  int? id;
  int? scheduleId;
  String? from;
  String? to;
  int? status;
  String? createdAt;
  String? updatedAt;
  Schedule? schedule;

  SlotIDModel(
      {this.id,
      this.scheduleId,
      this.from,
      this.to,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.schedule});

  SlotIDModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['schedule_id'];
    from = json['from'];
    to = json['to'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    schedule =
        json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null;
  }
}

class Schedule {
  int? id;
  String? dayName;
  int? status;
  String? createdAt;
  String? updatedAt;

  Schedule(
      {this.id, this.dayName, this.status, this.createdAt, this.updatedAt});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayName = json['day_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
