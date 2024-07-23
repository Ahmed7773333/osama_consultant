import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:osama_consul/core/network/firebase_helper.dart';

import '../../../../../core/api/api_manager.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/eror/failuers.dart';
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
      await FirebaseHelper().makeCustomerChat(userModel);
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
      await FirebaseHelper().makeCustomerChat(userModel);
      return Right(userModel);
    } catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserModel>> signInGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return left(
            RemoteFailure(message: 'There are no google users on the device'));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      UserModel userr = UserModel(
          data: Data(
              token: user?.uid,
              name: user?.displayName,
              email: user?.email,
              createdAt: user?.metadata.creationTime.toString(),
              isAdmin: 0,
              phone: user?.phoneNumber));
      await FirebaseHelper().makeCustomerChat(userr);

      return right(userr);
    } catch (e) {
      debugPrint(e.toString());
      return left(RemoteFailure(message: e.toString()));
    }
  }
}
