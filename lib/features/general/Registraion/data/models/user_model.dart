class AuthResponseModel {
  bool? success;
  UserModel? data;
  String? message;

  AuthResponseModel({this.success, this.data, this.message});

  AuthResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class UserModel {
  String? token;
  int? id;
  String? name;
  String? email;
  String? phone;
  String? createdAt;
  int? isAdmin;
  String? fcm;
  String? provider;
  int? consultantCounter;
  String? isSub;

  UserModel(
      {this.token,
      this.id,
      this.name,
      this.email,
      this.createdAt,
      this.isAdmin,
      this.phone,
      this.fcm,
      this.provider,
      this.consultantCounter,
      this.isSub});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['created_at'];
    isAdmin = json['is_admin'];
    fcm = json['fcm_token'];
    provider = json['provider'];
    consultantCounter = json['consultants_count'];
    isSub = json['subscription'];
  }
}
