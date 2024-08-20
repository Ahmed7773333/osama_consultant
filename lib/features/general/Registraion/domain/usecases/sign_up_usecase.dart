import 'package:dartz/dartz.dart';

import '../../../../../core/eror/failuers.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repo.dart';

class SignUpUseCase {
  AuthRepo authRepo;

  SignUpUseCase(this.authRepo);

  Future<Either<Failures, AuthResponseModel>> call(
    String email,
    String password,
    String name,
    String repassword,
    String phone,
  ) =>
      authRepo.signUP(email, password, name, phone, repassword);
}
