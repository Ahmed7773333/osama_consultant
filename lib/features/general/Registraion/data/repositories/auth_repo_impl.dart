import 'package:dartz/dartz.dart';
import '../../../../../core/eror/failuers.dart';
import '../../domain/repositories/auth_repo.dart';
import '../datasources/auth_remote_ds.dart';
import '../models/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRmoteDs authRmoteDs;

  AuthRepoImpl(this.authRmoteDs);

  @override
  Future<Either<Failures, UserModel>> signIn(String email, String password) {
    return authRmoteDs.signIn(email, password);
  }

  @override
  Future<Either<Failures, UserModel>> signUP(
    String email,
    String password,
    String name,
    String phone,
    String repassword,
  ) {
    return authRmoteDs.signUP(email, password, name, phone, repassword);
  }

  @override
  Future<Either<Failures, UserModel>> signInGoogle() {
    return authRmoteDs.signInGoogle();
  }
}
