import 'package:dartz/dartz.dart';
import 'package:osama_consul/features/user/MyRequests/domain/repositories/my_requests_repo.dart';

import '../../../../../core/eror/failuers.dart';
import '../../data/models/all_meeting_response.dart';

class GetAllRequestsUseCase {
  MyRequestsRepo repo;
  GetAllRequestsUseCase(this.repo);
  Future<Either<Failures, List<RequestModel>>> call() => repo.getAllRequests();
}
