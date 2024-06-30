import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/api/api_manager.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/eror/failuers.dart';
import '../models/user_model.dart';
import 'auth_remote_ds.dart';

class AuthRemoteDSImpl implements AuthRmoteDs {
  ApiManager apiManager;

  AuthRemoteDSImpl(this.apiManager);

  @override
  Future<Either<Failures, UserModel>> signIn(
      String email, String password) async {
    try {
      Response response = await apiManager.postData(EndPoints.login,
          body: {"email": email, "password": password});

      UserModel userModel = UserModel.fromJson(response.data);
      return Right(userModel);
    } catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserModel>> signUP(String email, String password,
      String name, String phone, String rePassword) async {
    try {
      Response response = await apiManager.postData(EndPoints.signup, body: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "c_password": rePassword
      });
      debugPrint('here');
      UserModel userModel = UserModel.fromJson(response.data);
      return Right(userModel);
    } catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
