import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:osama_consul/core/api/api_manager.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/features/user/MyRequests/data/datasources/my_requests_ds_remote.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/cache/shared_prefrence.dart';

class MyRequestsDsRemoteImpl extends MyRequestsDsRemote {
  ApiManager apiManager;
  MyRequestsDsRemoteImpl(this.apiManager);
  @override
  Future<Either<Failures, List<RequestModel>>> getAllRequests() async {
    try {
      Response response = await apiManager.getDataa(
        '${EndPoints.confirmBooking}?user_id=${(await UserPreferences.getId()) ?? ''}&per_page=10',
        data: {
          'Authorization': 'Bearer ${(await UserPreferences.getToken()) ?? ''}'
        },
      );
      AllMeetingResponse meeting = AllMeetingResponse.fromJson(response.data);
      return right(meeting.data!.data!);
    } catch (e) {
      debugPrint(e.toString());
      return left(RemoteFailure(message: e.toString()));
    }
  }
}
