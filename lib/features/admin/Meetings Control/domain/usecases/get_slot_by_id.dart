import 'package:dartz/dartz.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/id_slot_model.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/repositories/slots_repo.dart';

import '../../../../../core/eror/failuers.dart';

class GetSlotById {
  SlotsRepo slotsRepo;
  GetSlotById(this.slotsRepo);
  Future<Either<Failures, IdSlotModel>> call(int id) =>
      slotsRepo.getSlotById(id);
}
