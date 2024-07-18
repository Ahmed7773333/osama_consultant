import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/app_styles.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/all_schedules_model.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/presentation/bloc/meetings_control_bloc.dart';

Widget DaysListView(
    List<ScheduleModel> daysList, MeetingsControlBloc bloc, int selected) {
  void _toggleSelection(int index) {
    // Since this is now a stateless widget function, you need to handle state management outside this function.
    // For example, use a state management solution like Provider, Bloc, or setState in a parent stateful widget.
  }

  return SizedBox(
    height: 60.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: daysList.length,
      itemBuilder: (context, index) {
        bool isSelected = selected == index;

        return GestureDetector(
          onTap: () {
            // _toggleSelection(index);
            // Example: Navigator.pushNamed(context, '/yourRoute', arguments: daysList[index]);
            bloc.add(GetScheduleByIdEvent(index + 1));
          },
          child: Chip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  daysList[index].dayName ?? '',
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
            labelStyle: const TextStyle(color: Colors.black),
          ),
        );
      },
    ),
  );
}
