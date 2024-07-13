// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../domain/usecases/confirem_booking.dart';
import '../../../domain/usecases/pick_date.dart';
import '../../../domain/usecases/pick_duration.dart';
import '../../../domain/usecases/pick_time.dart';
import '../../widgets/booking_widgets.dart';

class MeetingBooking extends StatefulWidget {
  const MeetingBooking({super.key});

  @override
  _MeetingBookingState createState() => _MeetingBookingState();
}

class _MeetingBookingState extends State<MeetingBooking> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  Duration? _meetingDuration;
  Duration? _notificationDuration;

  void _pickDate() async {
    DateTime? picked = await PickDate().call(context);
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _pickTime() async {
    TimeOfDay? picked = await PickTime().call(context);
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _pickDuration() async {
    Duration? picked = await PickDuration().call(context);
    if (picked != null) {
      setState(() {
        _meetingDuration = picked;
      });
    }
  }

  void _pickNotificationDuration() async {
    Duration? picked = await showDialog<Duration>(
      context: context,
      builder: (BuildContext context) {
        return const DurationPickerDialog(
          initialDuration: Duration(minutes: 30),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Meeting'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pickDate,
              child: Text(
                _selectedDate == null
                    ? 'Select Date'
                    : DateFormat.yMMMd().format(_selectedDate!),
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: _pickTime,
              child: Text(
                _selectedTime == null
                    ? 'Select Time'
                    : _selectedTime!.format(context),
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: _pickDuration,
              child: Text(
                _meetingDuration == null
                    ? 'Select Duration'
                    : '${_meetingDuration!.inHours} hours ${_meetingDuration!.inMinutes % 60} minutes',
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            SizedBox(height: 20.h),
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
              onPressed: () => ConfirmBookingUseCase().call(
                  context: context,
                  selectedDate: _selectedDate,
                  selectedTime: _selectedTime,
                  meetingDuration: _meetingDuration,
                  notificationDuration: _notificationDuration),
              child: Text('Confirm Booking', style: TextStyle(fontSize: 20.sp)),
            ),
          ],
        ),
      ),
    );
  }
}
