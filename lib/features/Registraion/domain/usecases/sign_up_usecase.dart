import 'package:dartz/dartz.dart';
import 'package:osama_consultant/features/Registraion/data/models/user_model.dart';

import '../../../../core/eror/failuers.dart';
import '../repositories/auth_repo.dart';

class SignUpUseCase {
  AuthRepo authRepo;

  SignUpUseCase(this.authRepo);

  Future<Either<Failures, UserModel>> call(String email, String password,
          String name, String repassword, String phone) =>
      authRepo.signUP(email, password, name, phone, repassword);
}
