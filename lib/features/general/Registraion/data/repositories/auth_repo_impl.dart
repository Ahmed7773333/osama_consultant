import 'package:dartz/dartz.dart';
import '../../../../../core/eror/failuers.dart';
import '../../domain/repositories/auth_repo.dart';
import '../datasources/auth_remote_ds.dart';
import '../models/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRmoteDs authRmoteDs;

  AuthRepoImpl(this.authRmoteDs);

  @override
  Future<Either<Failures, AuthResponseModel>> signIn(
      String email, String password, String fcm) {
    return authRmoteDs.signIn(email, password, fcm);
  }

  @override
  Future<Either<Failures, AuthResponseModel>> signUP(
      String email,
      String password,
      String name,
      String phone,
      String repassword,
      String fcm) {
    return authRmoteDs.signUP(email, password, name, phone, repassword, fcm);
  }

  @override
  Future<Either<Failures, AuthResponseModel>> signInGoogle() {
    return authRmoteDs.signInGoogle();
  }
}
