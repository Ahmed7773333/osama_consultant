import 'package:osama_consul/features/user/HomeLayout/domain/repositories/home_user_repo.dart';

class LogoutUseCase {
  HomeUserRepo repo;
  LogoutUseCase(this.repo);
  Future<void> call() => repo.logout();
}
