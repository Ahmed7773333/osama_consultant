import 'package:dartz/dartz.dart';

import '../../../../../core/eror/failuers.dart';
import '../../../../user/MyRequests/data/models/all_meeting_response.dart';

abstract class RequestsAdminDsRemote {
  Future<Either<Failures, List<RequestModel>>> getAllRequests();
}