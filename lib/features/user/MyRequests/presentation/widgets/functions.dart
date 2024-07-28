import 'package:intl/intl.dart';

String convertEgyptTimeToLocal(String egyptTime) {
  // Parse the input time in Egypt time zone
  DateFormat egyptTimeFormat = DateFormat('HH:mm:ss');
  DateTime egyptDateTime = egyptTimeFormat.parse(egyptTime);

  // Define the time zone offset for Egypt (GMT+2)
  Duration egyptTimeZoneOffset = const Duration(hours: 2);

  // Convert Egypt time to UTC
  DateTime utcDateTime = egyptDateTime.subtract(egyptTimeZoneOffset);

  // Get the local time zone offset of the device
  Duration localTimeZoneOffset = DateTime.now().timeZoneOffset;

  // Convert UTC time to local time
  DateTime localDateTime = utcDateTime.add(localTimeZoneOffset);

  // Format the time to 12-hour format with AM/PM
  String formattedTime = DateFormat.jm().format(localDateTime);

  return formattedTime;
}
