class AllMeetingResponse {
  bool? success;
  PageModel? data;
  String? message;

  AllMeetingResponse({this.success, this.data, this.message});

  AllMeetingResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? PageModel.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class PageModel {
  int? currentPage;
  List<RequestModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  PageModel(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  PageModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <RequestModel>[];
      json['data'].forEach((v) {
        data!.add(RequestModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class RequestModel {
  int? id;
  String? title;
  int? userId;
  int? scheduleSlotId;
  String? meetingStatus;
  String? meetingDate;
  String? createdAt;
  String? updatedAt;
  ScheduleSlot? scheduleSlot;
  String? rtcToken;

  RequestModel(
      {this.id,
      this.title,
      this.userId,
      this.scheduleSlotId,
      this.meetingStatus,
      this.meetingDate,
      this.createdAt,
      this.updatedAt,
      this.scheduleSlot,
      this.rtcToken});

  RequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['user_id'];
    scheduleSlotId = json['schedule_slot_id'];
    meetingStatus = json['meeting_status'];
    meetingDate = json['meeting_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rtcToken = json['rtc_token'];
    scheduleSlot = json['schedule_slot'] != null
        ? ScheduleSlot.fromJson(json['schedule_slot'])
        : null;
  }
}

class ScheduleSlot {
  int? id;
  int? scheduleId;
  String? from;
  String? to;
  int? status;
  String? createdAt;
  String? updatedAt;

  ScheduleSlot(
      {this.id,
      this.scheduleId,
      this.from,
      this.to,
      this.status,
      this.createdAt,
      this.updatedAt});

  ScheduleSlot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['schedule_id'];
    from = json['from'];
    to = json['to'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
}
