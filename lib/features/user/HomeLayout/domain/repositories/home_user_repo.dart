import 'package:dartz/dartz.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/features/user/HomeLayout/data/models/meeting_booking.dart';

abstract class HomeUserRepo {
  Future<Either<Failures, MeetingModel>> confirmBooking(MeetingBody meet);
  Future<void> logout();
}
