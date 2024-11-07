import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/componetns.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/cubit/myrequests_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../../core/utils/app_animations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../general/Meeting Screen/meeting_screen.dart';
import '../widgets/functions.dart';

class RequestDetails extends StatefulWidget {
  const RequestDetails(this.cubit, {super.key});
  final MyrequestsCubit cubit;

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  //TODO: production function
  Future<void> buttonPress(String status) async {
    if (status == 'awaiting-payment') {
      widget.cubit.getAuthToken();
    } else if (status == 'in-progress') {
      int userId = (await UserPreferences.getId())!;
      Navigator.push(
          context,
          RightRouting(MeetingScreen(
              userId,
              widget.cubit.userRequest?.rtcToken ?? '',
              widget.cubit.userRequest?.title ?? '')));
    } else {
      null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.requestDetails),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Components.reloadPull(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildSlotCard(widget.cubit.userRequest!, context),
                SizedBox(height: 20.h),
                Text(
                  widget.cubit.userRequest!.meetingStatus == 'awaiting-payment'
                      ? '${localizations.pay} \$30'
                      : widget.cubit.userRequest!.meetingStatus == 'confirmed'
                          ? localizations.join
                          : localizations.waitingForPayment,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () async {
                    int userId = (await UserPreferences.getId())!;
                    widget.cubit.userRequest!.meetingStatus ==
                            'awaiting-payment'
                        ? widget.cubit.getAuthToken()
                        : Navigator.push(
                            context,
                            RightRouting(MeetingScreen(
                                userId,
                                '007eJxTYHD4HP3Jo2ReR9PvmSuqpucuMbrawJJ35t5DhR2nnsxcIdGnwGBmmpJqmWiRamphmmySmGxqkWKYaGCelAwkUyxTLJOn5mmnNwQyMlyZwsXKyACBID4rQ0lqcXEJAwMAU/sitg==',
                                'tesst')));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    widget.cubit.userRequest!.meetingStatus ==
                            'awaiting-payment'
                        ? localizations.pay
                        : localizations.join,
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          onLoad: () {
            widget.cubit.getAllRequests();
            debugPrint(widget.cubit.allRequests
                .firstWhere((test) {
                  return widget.cubit.userRequest!.id == test.id;
                })
                .id
                .toString());
            widget.cubit.setRequest(widget.cubit.allRequests.firstWhere((test) {
              return widget.cubit.userRequest!.id == test.id;
            }));
            setState(() {});
          },
        ),
      ),
    );
  }
}

Widget buildSlotCard(RequestModel meeting, context) {
  final localizations = AppLocalizations.of(context)!;

  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    margin: EdgeInsets.symmetric(vertical: 10.h),
    child: Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.event, color: AppColors.secondry),
              SizedBox(width: 10.w),
              Text(
                localizations.meetingDetails,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondry,
                ),
              ),
            ],
          ),
          Divider(thickness: 1.h, color: Colors.grey),
          SizedBox(height: 10.h),
          Text('${localizations.id} ${meeting.id}',
              style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 5.h),
          Text('${localizations.title} ${meeting.title}',
              style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 5.h),
          Text(
            '${localizations.from} ${convertEgyptTimeToLocal((meeting.scheduleSlot?.from)!)}',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 5.h),
          Text(
            '${localizations.to} ${convertEgyptTimeToLocal((meeting.scheduleSlot?.to)!)}',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 5.h),
          Text(
            '${localizations.status} ${meeting.meetingStatus}',
            style: TextStyle(
              fontSize: 16.sp,
              color: meeting.meetingStatus == 'confirmed'
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            '${localizations.schedule} ${meeting.meetingDate}',
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    ),
  );
}
