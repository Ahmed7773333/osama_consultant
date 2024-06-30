import 'package:dartz/dartz.dart';
import 'package:osama_consultant/features/Registraion/data/models/user_model.dart';

import '../../../../core/eror/failuers.dart';

abstract class AuthRmoteDs {
  Future<Either<Failures, UserModel>> signIn(String email, String password);
  Future<Either<Failures, UserModel>> signUP(String email, String password,
      String name, String phone, String rePassword);
}
