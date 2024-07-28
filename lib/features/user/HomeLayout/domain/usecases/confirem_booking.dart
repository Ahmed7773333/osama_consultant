import 'package:dartz/dartz.dart';
import 'package:osama_consul/features/user/HomeLayout/domain/repositories/home_user_repo.dart';
import '../../../../../core/eror/failuers.dart';
import '../../data/models/meeting_booking.dart';

class ConfirmBookingUseCase {
  HomeUserRepo repo;
  ConfirmBookingUseCase(this.repo);
  Future<Either<Failures, MeetingModel>> call(MeetingBody meeting) =>
      repo.confirmBooking(meeting);
}
