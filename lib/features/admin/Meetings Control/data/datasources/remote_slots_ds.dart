import 'package:dartz/dartz.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/add_slot.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/all_schedules_model.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/id_slot_model.dart';

import '../../../../../core/eror/failuers.dart';
import '../models/id_schedule_model.dart';

abstract class RemoteSlotsDs {
  Future<Either<Failures, AllSchedulesModel>> getAllSchedules();
  Future<Either<Failures, IdScheduleModel>> getScheduleById(int id);
  Future<Either<Failures, AddSlotModel>> addSlot(SlotToAdd slot);
  Future<Either<Failures, IdSlotModel>> getSlotById(int id);
}
