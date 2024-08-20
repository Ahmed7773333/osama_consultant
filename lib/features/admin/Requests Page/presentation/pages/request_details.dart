import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/componetns.dart';
import 'package:osama_consul/features/admin/Requests%20Page/presentation/bloc/requests_page_bloc.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';

import '../../../../../core/utils/app_animations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../general/Meeting Screen/meeting_screen.dart';
import '../../../../user/MyRequests/presentation/widgets/functions.dart';

class RequestAdminDetails extends StatefulWidget {
  const RequestAdminDetails(this.bloc, {super.key});
  final RequestsPageBloc bloc;

  @override
  State<RequestAdminDetails> createState() => _RequestAdminDetailsState();
}

class _RequestAdminDetailsState extends State<RequestAdminDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Components.reloadPull(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildSlotCard(widget.bloc.userRequest!),
                SizedBox(height: 20.h),
                Text(
                  widget.bloc.userRequest!.meetingStatus == 'confirmed'
                      ? 'You can join when Time comes'
                      : '',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () async {
                    widget.bloc.userRequest!.meetingStatus == 'confirmed'
                        ? Navigator.push(
                            context,
                            RightRouting(MeetingScreen(
                                0,
                                '007eJxTYJA3uu+U+uUuWzfnuacVW/1i7we7dHFc/CyxkCm3+n3LqT4FBjPTlFTLRItUUwvTZJPEZFOLFMNEA/OkZCCZYplimXziyJG0hkBGhnP73jEzMkAgiM/GUJJaXFJSycAAAPVDIyw=',
                                'testty')))
                        : null;
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    widget.bloc.userRequest!.meetingStatus == 'confirmed'
                        ? 'join'
                        : '',
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          onLoad: () {
            print(widget.bloc.userRequest?.rtcToken ?? 'no token');

            widget.bloc.add(GetAllRequestsAdminEvent());
            widget.bloc.add(
                SetRequestAdminEvent(widget.bloc.allRequests.firstWhere((test) {
              return widget.bloc.userRequest!.id == test.id;
            })));
            setState(() {});
          },
        ),
      ),
    );
  }
}

Widget buildSlotCard(RequestModel meeting) {
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
                'Meeting Details',
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
          Text('ID: ${meeting.id}', style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 5.h),
          Text('Title: ${meeting.title}', style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 5.h),
          Text(
            'From: ${convertEgyptTimeToLocal((meeting.scheduleSlot?.from)!)}',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 5.h),
          Text(
            'To: ${convertEgyptTimeToLocal((meeting.scheduleSlot?.to)!)}',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 5.h),
          Text(
            'Status: ${meeting.meetingStatus}',
            style: TextStyle(
              fontSize: 16.sp,
              color: meeting.meetingStatus == 'confirmed'
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'Schedule: ${meeting.meetingDate}',
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    ),
  );
}
