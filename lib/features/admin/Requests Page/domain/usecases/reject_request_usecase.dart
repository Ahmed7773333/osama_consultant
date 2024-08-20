import '../repositories/requests_admin_repo.dart';

class RejectRequestUsecase {
  RequestsAdminRepo repo;
  RejectRequestUsecase(this.repo);
  Future<void> call(int id) => repo.rejectOrder(id);
}
