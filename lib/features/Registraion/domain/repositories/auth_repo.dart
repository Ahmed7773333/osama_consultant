import 'package:dartz/dartz.dart';
import '../../../../core/eror/failuers.dart';
import '../entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failures, UserEntity>> signIn(String email, String password);
  Future<Either<Failures, UserEntity>> signUP(
      String email, String password, String name);
}