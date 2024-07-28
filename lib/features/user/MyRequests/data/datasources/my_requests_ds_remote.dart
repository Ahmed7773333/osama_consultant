import 'package:dartz/dartz.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';

abstract class MyRequestsDsRemote {
  Future<Either<Failures, List<RequestModel>>> getAllRequests();
}
