import 'package:dartz/dartz.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/features/user/MyRequests/data/datasources/my_requests_ds_remote.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';
import 'package:osama_consul/features/user/MyRequests/domain/repositories/my_requests_repo.dart';

class MyRequestsRepoImpl extends MyRequestsRepo {
  MyRequestsDsRemote remote;
  MyRequestsRepoImpl(this.remote);
  @override
  Future<Either<Failures, List<RequestModel>>> getAllRequests() {
    return remote.getAllRequests();
  }
}
