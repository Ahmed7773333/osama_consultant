import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/cubit/myrequests_cubit.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen(this.meeting, this.cubit, {super.key});
  final RequestModel meeting;
  final MyrequestsCubit cubit;
  Widget buildSlotCard() {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${meeting.id}', style: TextStyle(fontSize: 16.sp)),
            Text('title: ${meeting.title}', style: TextStyle(fontSize: 16.sp)),
            Text('Schedule ID: 1001', style: TextStyle(fontSize: 16.sp)),
            Text('From: ${meeting.scheduleSlot?.from}',
                style: TextStyle(fontSize: 16.sp)),
            Text('To: ${meeting.scheduleSlot?.to}',
                style: TextStyle(fontSize: 16.sp)),
            Text('Status: ${meeting.meetingStatus}',
                style: TextStyle(fontSize: 16.sp)),
            Text('Schedule: ${meeting.meetingDate}',
                style: TextStyle(fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildSlotCard(),
              SizedBox(height: 20.h),
              const Text(
                'The fee will be 30\$',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  cubit.getAuthToken();
                },
                child: Text(
                  'Pay',
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
