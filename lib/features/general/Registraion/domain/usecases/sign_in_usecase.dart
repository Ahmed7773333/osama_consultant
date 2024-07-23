import 'package:dartz/dartz.dart';

import '../../../../../core/eror/failuers.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repo.dart';

class SignInUseCase {
  AuthRepo authRepo;

  SignInUseCase(this.authRepo);

  Future<Either<Failures, UserModel>> call(String email, String password) =>
      authRepo.signIn(email, password);
}
