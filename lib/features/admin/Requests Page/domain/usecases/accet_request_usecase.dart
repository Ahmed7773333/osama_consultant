import '../repositories/requests_admin_repo.dart';

class AccetRequestUsecase {
  RequestsAdminRepo repo;
  AccetRequestUsecase(this.repo);
  Future<void> call(int id) => repo.acceptOrder(id);
}
