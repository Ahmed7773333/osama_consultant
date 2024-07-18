class AllSchedulesModel {
  bool? success;
  List<ScheduleModel>? data;
  String? message;

  AllSchedulesModel({this.success, this.data, this.message});

  AllSchedulesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ScheduleModel>[];
      json['data'].forEach((v) {
        data!.add(ScheduleModel.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class ScheduleModel {
  int? id;
  String? dayName;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<SlotModel>? slots;

  ScheduleModel(
      {this.id,
      this.dayName,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.slots});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayName = json['day_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['slots'] != null) {
      slots = <SlotModel>[];
      json['slots'].forEach((v) {
        slots!.add(SlotModel.fromJson(v));
      });
    }
  }
}

class SlotModel {
  int? id;
  int? scheduleId;
  String? from;
  String? to;
  int? status;
  String? createdAt;
  String? updatedAt;

  SlotModel(
      {this.id,
      this.scheduleId,
      this.from,
      this.to,
      this.status,
      this.createdAt,
      this.updatedAt});

  SlotModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['schedule_id'];
    from = json['from'];
    to = json['to'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
