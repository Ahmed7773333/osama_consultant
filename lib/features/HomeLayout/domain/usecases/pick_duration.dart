import 'package:flutter/material.dart';

import '../../presentation/widgets/booking_widgets.dart';

class PickDuration {
  Future<Duration?> call(BuildContext context) async {
    return await showDialog<Duration>(
      context: context,
      builder: (BuildContext context) {
        return const DurationPickerDialog(
          initialDuration: Duration(hours: 1),
        );
      },
    );
  }
}
