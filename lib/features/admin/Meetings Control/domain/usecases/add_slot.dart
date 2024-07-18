import 'package:dartz/dartz.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/repositories/slots_repo.dart';

import '../../../../../core/eror/failuers.dart';
import '../../data/models/add_slot.dart';

class AddSlotUseCase {
  SlotsRepo slotsRepo;
  AddSlotUseCase(this.slotsRepo);
  Future<Either<Failures, AddSlotModel>> call(SlotToAdd slot) =>
      slotsRepo.addSlot(slot);
}
