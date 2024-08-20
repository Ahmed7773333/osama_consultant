import 'package:dartz/dartz.dart';
import '../../../../../core/eror/failuers.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failures, AuthResponseModel>> signIn(
      String email, String password);
  Future<Either<Failures, AuthResponseModel>> signUP(String email,
      String password, String name, String phone, String repassword);

  Future<void> forgetPasswordRequest(String email);
  Future<void> changePassword(String email, String newPassword, int otp);
  // Future<Either<Failures, AuthResponseModel>> signInGoogle();
  // Future<Either<Failures, AuthResponseModel>> signUpGoogle();
}
