import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget chipp(VoidCallback onTab, int index, int selected) {
  return GestureDetector(
    onTap: onTab,
    child: Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            index == 0 ? 'All' : 'un read chats',
          ),
          if (index == selected)
            const Icon(
              Icons.check_circle,
              color: Colors.black,
            ),
        ],
      ),
      side: BorderSide(color: Colors.black),
      padding: EdgeInsets.all(8.r),
      backgroundColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.black),
    ),
  );
}
