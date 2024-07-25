class UserModel {
  bool? success;
  Data? data;
  String? message;

  UserModel({this.success, this.data, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  String? token;
  int? id;
  String? name;
  String? email;
  String? phone;
  String? createdAt;
  int? isAdmin;
  String? fcm;

  Data(
      {this.token,
      this.id,
      this.name,
      this.email,
      this.createdAt,
      this.isAdmin,
      this.phone,
      this.fcm});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['created_at'];
    isAdmin = json['is_admin'];
    fcm = json['fcm_token'];
  }
}
