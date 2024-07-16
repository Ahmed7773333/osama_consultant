// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/app_styles.dart';

class DaysListView extends StatefulWidget {
  final List<Map<String, dynamic>> daysList;

  const DaysListView(this.daysList, {super.key});

  @override
  _DaysListViewState createState() => _DaysListViewState();
}

class _DaysListViewState extends State<DaysListView> {
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
      height: 60.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
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
                children: [
                  Text(
                    widget.daysList[index]['day'],
                    style: AppStyles.whiteLableStyle,
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                ],
              ),
              padding: EdgeInsets.all(8.0.r),
              backgroundColor: Colors.green,
              labelStyle: TextStyle(color: Colors.black),
            ),
          );
        },
      ),
    );
  }
}
