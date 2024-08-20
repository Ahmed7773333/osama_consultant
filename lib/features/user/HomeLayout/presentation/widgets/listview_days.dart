import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/app_styles.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/all_schedules_model.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/bloc/homelayout_bloc.dart';

import '../../../../../core/utils/app_colors.dart';

Widget daysListView(
    List<ScheduleModel> daysList, HomelayoutBloc bloc, int selected) {
  return SizedBox(
    height: 60.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: daysList.length,
      itemBuilder: (context, index) {
        bool isSelected = selected == index;

        return GestureDetector(
          onTap: () {
            bloc.add(GetScheduleByIdUserEvent(index + 1));
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
            backgroundColor: AppColors.secondry,
            labelStyle: const TextStyle(color: Colors.black),
          ),
        );
      },
    ),
  );
}
