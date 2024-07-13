import 'package:dartz/dartz.dart';

import '../../../../core/eror/failuers.dart';
import '../models/user_model.dart';

abstract class AuthRmoteDs {
  Future<Either<Failures, UserModel>> signIn(String email, String password);
  Future<Either<Failures, UserModel>> signUP(String email, String password,
      String name, String phone, String rePassword);
  Future<Either<Failures, UserModel>> signInGoogle();
}
