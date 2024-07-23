// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/app_strings.dart';
import 'package:osama_consul/core/utils/app_styles.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/presentation/widgets/time_gridview.dart';

import '../../../../../admin/Meetings Control/data/models/id_slot_model.dart';
import '../../bloc/homelayout_bloc.dart';
import '../../widgets/booking_widgets.dart';
import '../../widgets/listview_days.dart';

class MeetingBooking extends StatefulWidget {
  const MeetingBooking(this.bloc, {super.key});
  final HomelayoutBloc bloc;

  @override
  _MeetingBookingState createState() => _MeetingBookingState();
}

class _MeetingBookingState extends State<MeetingBooking> {
  Duration? _notificationDuration;

  void _pickNotificationDuration() async {
    Duration? picked = await showDialog<Duration>(
      context: context,
      builder: (BuildContext context) {
        return const DurationPickerDialog(
          initialDuration: Duration(minutes: 5),
        );
      },
    );
    if (picked != null) {
      setState(() {
        _notificationDuration = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppStrings.selectDay, style: AppStyles.greenLableStyle),
              SizedBox(height: 20.h),
              daysListView(
                  widget.bloc.daysOfWeek, widget.bloc, widget.bloc.selectedDay),
              SizedBox(height: 20.h),
              Text(AppStrings.selectTime, style: AppStyles.greenLableStyle),
              SizedBox(height: 20.h),
              gridViewTimes(widget.bloc.timesOfDay, widget.bloc),
              if (widget.bloc.slotDetails != null)
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.h),
                      Text(AppStrings.slotDetails,
                          style: AppStyles.greenLableStyle),
                      SizedBox(height: 20.h),
                      buildSlotCard(widget.bloc.slotDetails!),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Send a Request',
                            style: TextStyle(fontSize: 20.sp)),
                      ),
                    ]),
              SizedBox(height: 20.h),
              Text(AppStrings.selectNotifyTime,
                  style: AppStyles.greenLableStyle),
              ElevatedButton(
                onPressed: _pickNotificationDuration,
                child: Text(
                  _notificationDuration == null
                      ? 'Select Notification Time'
                      : '${_notificationDuration!.inMinutes} minutes before',
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
              SizedBox(height: 50.h),
              ElevatedButton(
                onPressed: () {},
                child:
                    Text('Confirm Booking', style: TextStyle(fontSize: 20.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSlotCard(SlotIDModel slot) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${slot.id}', style: TextStyle(fontSize: 16.sp)),
            Text('Schedule ID: ${slot.scheduleId}',
                style: TextStyle(fontSize: 16.sp)),
            Text('From: ${slot.from}', style: TextStyle(fontSize: 16.sp)),
            Text('To: ${slot.to}', style: TextStyle(fontSize: 16.sp)),
            Text('Status: ${slot.status}', style: TextStyle(fontSize: 16.sp)),
            Text('Created At: ${slot.createdAt}',
                style: TextStyle(fontSize: 16.sp)),
            Text('Updated At: ${slot.updatedAt}',
                style: TextStyle(fontSize: 16.sp)),
            if (slot.schedule != null)
              Text('Schedule: ${slot.schedule!.dayName}',
                  style: TextStyle(fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }
}
