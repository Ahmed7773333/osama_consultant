// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/app_strings.dart';
import 'package:osama_consul/core/utils/app_styles.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/widgets/gridview_times.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/widgets/listview_days.dart';

import '../../widgets/booking_widgets.dart';

class MeetingBooking extends StatefulWidget {
  const MeetingBooking({super.key});

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
    // final HomelayoutBloc bloc=widget.bloc;
    final List<Map<String, dynamic>> daysOfWeek = [
      {'day': 'Monday', 'on': true},
      {'day': 'Tuesday', 'on': false},
      {'day': 'Wednesday', 'on': false},
      {'day': 'Thursday', 'on': false},
      {'day': 'Friday', 'on': false},
      {'day': 'saturday', 'on': false},
      {'day': 'Sunday', 'on': false},
    ];
    final List<Map<String, dynamic>> timesOfDay = [
      {'day': '11:00  to 12:00 ', 'on': true},
      {'day': '11:00  to 12:00 ', 'on': false},
      {'day': '11:00  to 12:00 ', 'on': false},
      {'day': '11:00  to 12:00 ', 'on': false},
      {'day': '11:00  to 12:00 ', 'on': false},
      {'day': '11:00  to 12:00 ', 'on': false},
      {'day': '11:00  to 12:00 ', 'on': false},
    ];
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
              // DaysListView(daysOfWeek),
              SizedBox(height: 20.h),
              Text(AppStrings.selectTime, style: AppStyles.greenLableStyle),
              SizedBox(height: 20.h),
              TimesGridView(timesOfDay),
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
}
