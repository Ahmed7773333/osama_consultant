import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:osama_consul/core/api/api_manager.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';

import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/add_slot.dart';

import 'package:osama_consul/features/admin/Meetings%20Control/data/models/all_schedules_model.dart';

import 'package:osama_consul/features/admin/Meetings%20Control/data/models/id_schedule_model.dart';

import '../../../../../core/api/end_points.dart';
import 'remote_slots_ds.dart';

class RemoteSlotsDsImpl extends RemoteSlotsDs {
  RemoteSlotsDsImpl(this.apiManager);
  ApiManager apiManager;
  @override
  Future<Either<Failures, AllSchedulesModel>> getAllSchedules() async {
    try {
      Response response = await apiManager.getDataa(EndPoints.schedules, data: {
        'Authorization': 'Bearer ${await UserPreferences.getToken()}'
      });
      debugPrint('here');
      AllSchedulesModel userModel = AllSchedulesModel.fromJson(response.data);
      return Right(userModel);
    } catch (e) {
      return left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, IdScheduleModel>> getScheduleById(int id) async {
    try {
      Response response = await apiManager
          .getDataa('${EndPoints.schedules}/$id', data: {
        'Authorization': 'Bearer ${await UserPreferences.getToken()}'
      });
      debugPrint(await UserPreferences.getToken());
      IdScheduleModel userModel = IdScheduleModel.fromJson(response.data);
      return Right(userModel);
    } catch (e) {
      return left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, AddSlotModel>> addSlot(SlotToAdd slot) async {
    try {
      Response response = await apiManager.postDataa(EndPoints.slots,
          data: {'Authorization': 'Bearer ${await UserPreferences.getToken()}'},
          body: slot.toMap());
      debugPrint('here');
      AddSlotModel userModel = AddSlotModel.fromJson(response.data);
      return Right(userModel);
    } catch (e) {
      return left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<void> deleteSlot(int id) async {
    try {
      await apiManager.deleteData(
        EndPoints.slots + '/' + id.toString(),
        data: {'Authorization': 'Bearer ${await UserPreferences.getToken()}'},
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
