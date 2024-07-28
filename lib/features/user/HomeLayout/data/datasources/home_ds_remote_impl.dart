import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:osama_consul/core/api/api_manager.dart';
import 'package:osama_consul/core/api/end_points.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';
import 'package:osama_consul/features/user/HomeLayout/data/datasources/home_ds_remote.dart';
import 'package:osama_consul/features/user/HomeLayout/data/models/meeting_booking.dart';

import '../../../../../core/eror/failuers.dart';

class HomeDsRemoteImpl extends HomeDsRemote {
  ApiManager apiManager;
  HomeDsRemoteImpl(this.apiManager);
  @override
  Future<Either<Failures, MeetingModel>> confirmBooking(
      MeetingBody meet) async {
    try {
      Response response = await apiManager.postDataa(
        EndPoints.confirmBooking,
        body: meet.toJson(),
        data: {'Authorization': 'Bearer ${await UserPreferences.getToken()}'},
      );
      MeetingResponseModel meeting =
          MeetingResponseModel.fromJson(response.data);
      return right(meeting.data!);
    } catch (e) {
      debugPrint(e.toString());
      return left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    try {
      await apiManager.postDataa(
        EndPoints.logout,
        body: {'email': await UserPreferences.getEmail()},
        data: {'Authorization': 'Bearer ${await UserPreferences.getToken()}'},
      );
      await UserPreferences.removeUserData();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
