class MeetingBody {
  String? title;
  int? userId;
  int? scheduleSlotId;
  String? meetingDate;

  MeetingBody({this.title, this.userId, this.scheduleSlotId, this.meetingDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['user_id'] = userId;
    data['schedule_slot_id'] = scheduleSlotId;
    data['meeting_date'] = meetingDate;
    return data;
  }
}

class MeetingResponseModel {
  bool? success;
  MeetingModel? data;
  String? message;

  MeetingResponseModel({this.success, this.data, this.message});

  MeetingResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? MeetingModel.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class MeetingModel {
  int? id;
  String? title;
  int? userId;
  int? scheduleSlotId;
  String? meetingStatus;
  String? meetingDate;
  String? createdAt;
  String? updatedAt;
  UserModel? user;
  ScheduleSlotModel? scheduleSlot;

  MeetingModel(
      {this.id,
      this.title,
      this.userId,
      this.scheduleSlotId,
      this.meetingStatus,
      this.meetingDate,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.scheduleSlot});

  MeetingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['user_id'];
    scheduleSlotId = json['schedule_slot_id'];
    meetingStatus = json['meeting_status'];
    meetingDate = json['meeting_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    scheduleSlot = json['schedule_slot'] != null
        ? ScheduleSlotModel.fromJson(json['schedule_slot'])
        : null;
  }
}

class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? isAdmin;
  String? emailVerifiedAt;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.isAdmin,
      this.emailVerifiedAt,
      this.fcmToken,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isAdmin = json['is_admin'];
    emailVerifiedAt = json['email_verified_at'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class ScheduleSlotModel {
  int? id;
  int? scheduleId;
  String? from;
  String? to;
  int? status;
  String? createdAt;
  String? updatedAt;

  ScheduleSlotModel(
      {this.id,
      this.scheduleId,
      this.from,
      this.to,
      this.status,
      this.createdAt,
      this.updatedAt});

  ScheduleSlotModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['schedule_id'];
    from = json['from'];
    to = json['to'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
