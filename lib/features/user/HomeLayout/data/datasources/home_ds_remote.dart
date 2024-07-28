import 'package:dartz/dartz.dart';
import 'package:osama_consul/features/user/HomeLayout/data/models/meeting_booking.dart';

import '../../../../../core/eror/failuers.dart';

abstract class HomeDsRemote {
  Future<Either<Failures, MeetingModel>> confirmBooking(MeetingBody meet);
  Future<void> logout();
}
