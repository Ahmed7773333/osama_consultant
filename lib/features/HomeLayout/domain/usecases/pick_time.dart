import 'package:flutter/material.dart';

class PickTime {
  Future<TimeOfDay?> call(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }
}
