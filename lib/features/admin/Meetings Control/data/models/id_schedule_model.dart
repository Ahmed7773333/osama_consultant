import 'package:osama_consul/features/admin/Meetings%20Control/data/models/all_schedules_model.dart';

class IdScheduleModel {
  bool? success;
  ScheduleModel? data;
  String? message;

  IdScheduleModel({this.success, this.data, this.message});

  IdScheduleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ScheduleModel.fromJson(json['data']) : null;
    message = json['message'];
  }
}
