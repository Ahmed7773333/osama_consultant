import 'package:flutter/material.dart';

class PickDate {
  Future<DateTime?> call(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
  }
}
