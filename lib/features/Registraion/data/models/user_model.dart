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
  String? name;
  String? email;
  String? phone;
  String? createdAt;
  int? isAdmin;

  Data(
      {this.token,
      this.name,
      this.email,
      this.createdAt,
      this.isAdmin,
      this.phone});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['created_at'];
    isAdmin = json['is_admin'];
  }
}
