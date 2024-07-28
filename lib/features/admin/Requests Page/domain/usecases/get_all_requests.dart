import 'package:dartz/dartz.dart';

import '../../../../../core/eror/failuers.dart';
import '../../../../user/MyRequests/data/models/all_meeting_response.dart';
import '../repositories/requests_admin_repo.dart';

class GetAllRequestsAdminUseCase {
  RequestsAdminRepo repo;
  GetAllRequestsAdminUseCase(this.repo);
  Future<Either<Failures, List<RequestModel>>> call() => repo.getAllRequests();
}
