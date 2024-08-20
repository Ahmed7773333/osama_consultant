import 'package:dartz/dartz.dart';

import '../../../../../core/eror/failuers.dart';
import '../models/user_model.dart';

abstract class AuthRmoteDs {
  Future<Either<Failures, AuthResponseModel>> signIn(
      String email, String password);
  Future<Either<Failures, AuthResponseModel>> signUP(String email,
      String password, String name, String phone, String rePassword);
  Future<void> forgetPasswordRequest(String email);
  Future<void> changePassword(String email, String newPassword, int otp);
}
