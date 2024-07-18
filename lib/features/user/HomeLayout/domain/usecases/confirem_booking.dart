import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/cache/notification_service.dart';

class ConfirmBookingUseCase {
  Future<void> call({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    Duration? meetingDuration,
    Duration? notificationDuration,
    required BuildContext context,
  }) async {
    if (selectedDate != null &&
        selectedTime != null &&
        meetingDuration != null &&
        notificationDuration != null) {
      final now = DateTime.now();
      final meetingDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      final notificationDateTime =
          meetingDateTime.subtract(notificationDuration);
      debugPrint(notificationDateTime.toString());
      if (notificationDateTime.isAfter(now)) {
        NotificationService().zonedScheduleNotification(0, 'Meeting Reminder',
            'You have a meeting scheduled', notificationDateTime);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Meeting booked for ${DateFormat.yMMMd().format(selectedDate)} at ${selectedTime.format(context)}\nDuration: ${meetingDuration.inHours} hours ${meetingDuration.inMinutes % 60} minutes\nNotification: ${notificationDuration.inMinutes} minutes before')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Notification time must be in the future. Please select a valid notification time.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all booking details')),
      );
    }
  }
}
