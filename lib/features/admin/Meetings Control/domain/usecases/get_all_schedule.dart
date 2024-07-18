import 'package:dartz/dartz.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/all_schedules_model.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/repositories/slots_repo.dart';

import '../../../../../core/eror/failuers.dart';

class GetAllSchedules {
  SlotsRepo slotsRepo;
  GetAllSchedules(this.slotsRepo);
  Future<Either<Failures, AllSchedulesModel>> call() =>
      slotsRepo.getAllSchedules();
}
