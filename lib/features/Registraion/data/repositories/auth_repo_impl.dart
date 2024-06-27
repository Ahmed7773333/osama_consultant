import 'package:dartz/dartz.dart';
import '../../../../core/eror/failuers.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../datasources/auth_remote_ds.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRmoteDs authRmoteDs;

  AuthRepoImpl(this.authRmoteDs);

  @override
  Future<Either<Failures, UserEntity>> signIn(String email, String password) {
    return authRmoteDs.signIn(email, password);
  }

  @override
  Future<Either<Failures, UserEntity>> signUP(
      String email, String password, String name) {
    return authRmoteDs.signUP(email, password, name);
  }
}
