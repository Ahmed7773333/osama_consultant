// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DurationPickerDialog extends StatefulWidget {
  final Duration initialDuration;

  const DurationPickerDialog({super.key, required this.initialDuration});

  @override
  _DurationPickerDialogState createState() => _DurationPickerDialogState();
}

class _DurationPickerDialogState extends State<DurationPickerDialog> {
  late Duration _selectedDuration;

  @override
  void initState() {
    super.initState();
    _selectedDuration = widget.initialDuration;
  }

  void _setDuration(Duration duration) {
    setState(() {
      _selectedDuration = duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Duration'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DurationPicker(
            duration: _selectedDuration,
            onChange: _setDuration,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedDuration);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class DurationPicker extends StatelessWidget {
  final Duration duration;
  final ValueChanged<Duration> onChange;

  const DurationPicker(
      {super.key, required this.duration, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            NumberPicker(
              value: duration.inHours,
              minValue: 0,
              maxValue: 23,
              onChanged: (value) => onChange(
                  Duration(hours: value, minutes: duration.inMinutes % 60)),
            ),
            const Text('hour'),
          ],
        ),
        Row(
          children: [
            NumberPicker(
              value: duration.inMinutes % 60,
              minValue: 0,
              maxValue: 59,
              onChanged: (value) =>
                  onChange(Duration(hours: duration.inHours, minutes: value)),
            ),
            const Text('minute'),
          ],
        ),
      ],
    );
  }
}

class NumberPicker extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const NumberPicker(
      {super.key,
      required this.value,
      required this.minValue,
      required this.maxValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: value > minValue ? () => onChanged(value - 1) : null,
          icon: const Icon(Icons.remove),
        ),
        Text('$value', style: TextStyle(fontSize: 20.sp)),
        IconButton(
          onPressed: value < maxValue ? () => onChanged(value + 1) : null,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
