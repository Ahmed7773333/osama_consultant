import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:osama_consul/core/network/firebase_helper.dart';

import '../../../../../core/api/api_manager.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/cache/notification_service.dart';
import '../../../../../core/eror/failuers.dart';
import '../models/user_model.dart';
import 'auth_remote_ds.dart';

class AuthRemoteDSImpl implements AuthRmoteDs {
  ApiManager apiManager;

  AuthRemoteDSImpl(this.apiManager);

  @override
  Future<Either<Failures, AuthResponseModel>> signIn(
      String email, String password) async {
    try {
      String fcm = (await NotificationService().getToken())!;

      Response response = await apiManager.postData(EndPoints.login,
          body: {"email": email, "password": password, 'fcm_token': fcm});

      AuthResponseModel userModel = AuthResponseModel.fromJson(response.data);
      await FirebaseHelper().makeCustomerChat(userModel);
      return Right(userModel);
    } catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, AuthResponseModel>> signUP(
    String email,
    String password,
    String name,
    String phone,
    String rePassword,
  ) async {
    try {
      String fcm = (await NotificationService().getToken())!;
      Response response = await apiManager.postData(EndPoints.signup, body: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "c_password": rePassword,
        "fcm_token": fcm
      });

      AuthResponseModel userModel = AuthResponseModel.fromJson(response.data);
      await FirebaseHelper().makeCustomerChat(userModel);
      return Right(userModel);
    } catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<void> changePassword(String email, String newPassword, int otp) async {
    await apiManager.postData(EndPoints.resetPassword,
        body: {"email": email, "password": newPassword, 'otp': otp});
  }

  @override
  Future<void> forgetPasswordRequest(String email) async {
    await apiManager
        .postData(EndPoints.forgetPasswordRequest, body: {"email": email});
  }
/*
  
  Future<Either<Failures, AuthResponseModel>> signInGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'profile',
      ],
    );
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return left(
            RemoteFailure(message: 'There are no google users on the device'));
      }

      await googleUser.authentication;
      String fcm = (await NotificationService().getToken())!;

      Response response = await apiManager.postData(EndPoints.loginGoogle,
          body: {"email": googleUser.email, 'fcm_token': fcm});
      AuthResponseModel userr = AuthResponseModel.fromJson(response.data);

      await FirebaseHelper().makeCustomerChat(userr);

      return right(userr);
    } catch (e) {
      debugPrint(e.toString());
      return left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, AuthResponseModel>> signUpGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'profile',
        'https://www.googleapis.com/auth/user.phonenumbers.read',
      ],
    );
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return left(
            RemoteFailure(message: 'There are no google users on the device'));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      String fcm = (await NotificationService().getToken())!;

      String? phone =
          await apiManager.fetchPhoneNumber(googleAuth.accessToken!);
      debugPrint(phone);

      Response response =
          await apiManager.postData(EndPoints.signupGoogle, body: {
        "name": googleUser.displayName,
        "email": googleUser.email,
        'phone': phone,
        'fcm_token': fcm,
        "provider": "google"
      });

      AuthResponseModel userr = AuthResponseModel.fromJson(response.data);

      await FirebaseHelper().makeCustomerChat(userr);

      return right(userr);
    } catch (e) {
      debugPrint(e.toString());
      return left(RemoteFailure(message: e.toString()));
    }
  }*/
}
