import 'package:dartz/dartz.dart';
import '../../../../../core/eror/failuers.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failures, UserModel>> signIn(
      String email, String password, String fcm);
  Future<Either<Failures, UserModel>> signUP(String email, String password,
      String name, String phone, String repassword, String fcm);
  Future<Either<Failures, UserModel>> signInGoogle();
}
