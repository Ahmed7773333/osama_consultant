import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}
