import '../repositories/auth_repo.dart';

class ResetPasswordUsecase {
  AuthRepo authRepo;

  ResetPasswordUsecase(this.authRepo);

  Future<void> call(String email, String password, int otp) =>
      authRepo.changePassword(email, password, otp);
}
