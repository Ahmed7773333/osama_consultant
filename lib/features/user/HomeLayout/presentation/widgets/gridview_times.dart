// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_styles.dart';

class TimesGridView extends StatefulWidget {
  final List<Map<String, dynamic>> daysList;

  const TimesGridView(this.daysList, {super.key});

  @override
  _TimesGridViewState createState() => _TimesGridViewState();
}

class _TimesGridViewState extends State<TimesGridView> {
  void _toggleSelection(int index) {
    setState(() {
      for (int i = 0; i < widget.daysList.length; i++) {
        widget.daysList[i]['on'] = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          childAspectRatio: 5, // Adjust the aspect ratio to your preference
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.daysList.length,
        itemBuilder: (context, index) {
          bool isSelected = widget.daysList[index]['on'];

          return GestureDetector(
            onTap: () {
              _toggleSelection(index);
              // Example: Navigator.pushNamed(context, '/yourRoute', arguments: widget.daysList[index]);
            },
            child: Chip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.daysList[index]['day'],
                    style: AppStyles.whiteLableStyle,
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 20.r,
                    ),
                ],
              ),
              backgroundColor: Colors.green,
              labelStyle:
                  TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          );
        },
      ),
    );
  }
}
