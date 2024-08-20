import '../repositories/auth_repo.dart';

class ForgetPasswordUseCase {
  AuthRepo authRepo;

  ForgetPasswordUseCase(this.authRepo);

  Future<void> call(String email) => authRepo.forgetPasswordRequest(email);
}
