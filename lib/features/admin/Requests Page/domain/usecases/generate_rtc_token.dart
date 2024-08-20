import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';

import '../repositories/requests_admin_repo.dart';

class GenerateRtcToken {
  RequestsAdminRepo repo;
  GenerateRtcToken(this.repo);
  Future<void> call(RequestModel r) => repo.generateToken(r);
}
