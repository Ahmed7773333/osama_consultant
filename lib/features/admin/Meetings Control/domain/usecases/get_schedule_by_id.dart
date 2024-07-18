import 'package:dartz/dartz.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/id_schedule_model.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/repositories/slots_repo.dart';

import '../../../../../core/eror/failuers.dart';

class GetScheduleById {
  SlotsRepo slotsRepo;
  GetScheduleById(this.slotsRepo);
  Future<Either<Failures, IdScheduleModel>> call(int id) =>
      slotsRepo.getScheduleById(id);
}
