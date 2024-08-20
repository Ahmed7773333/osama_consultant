import 'package:dartz/dartz.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/features/admin/Requests%20Page/domain/repositories/requests_admin_repo.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';

import '../datasources/requests_admin_ds_remote.dart';

class RequestsAdminRepoImpl extends RequestsAdminRepo {
  RequestsAdminDsRemote remote;
  RequestsAdminRepoImpl(this.remote);
  @override
  Future<Either<Failures, List<RequestModel>>> getAllRequests() {
    return remote.getAllRequests();
  }

  @override
  Future<void> acceptOrder(int id) {
    return remote.acceptOrder(id);
  }

  @override
  Future<void> rejectOrder(int id) {
    return remote.rejectOrder(id);
  }

  @override
  Future<void> generateToken(RequestModel r) {
    return remote.generateToken(r);
  }
}
