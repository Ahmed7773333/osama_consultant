import 'package:osama_consul/features/admin/Meetings%20Control/domain/repositories/slots_repo.dart';

class DeleteSlot {
  SlotsRepo slotsRepo;
  DeleteSlot(this.slotsRepo);
  Future<void> call(int id) => slotsRepo.deleteSlot(id);
}
