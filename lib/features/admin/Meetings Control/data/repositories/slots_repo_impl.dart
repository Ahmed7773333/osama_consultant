import 'package:dartz/dartz.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/datasources/remote_slots_ds.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/add_slot.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/all_schedules_model.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/id_schedule_model.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/repositories/slots_repo.dart';

class SlotsRepoImpl extends SlotsRepo {
  RemoteSlotsDs remoteSlotsDs;
  SlotsRepoImpl(this.remoteSlotsDs);
  @override
  Future<Either<Failures, AddSlotModel>> addSlot(SlotToAdd slot) {
    return remoteSlotsDs.addSlot(slot);
  }

  @override
  Future<Either<Failures, AllSchedulesModel>> getAllSchedules() {
    return remoteSlotsDs.getAllSchedules();
  }

  @override
  Future<Either<Failures, IdScheduleModel>> getScheduleById(int id) {
    return remoteSlotsDs.getScheduleById(id);
  }
}
