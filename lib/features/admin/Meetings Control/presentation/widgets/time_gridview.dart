import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/all_schedules_model.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/bloc/homelayout_bloc.dart';
import '../../../../../core/utils/app_styles.dart';

Widget gridViewTimes(List<SlotModel> daysList, bloc) {
  return SizedBox(
    height:
        ((daysList.length % 2 == 0 ? daysList.length : daysList.length + 1) /
                2) *
            38.h,
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        childAspectRatio: 5, // Adjust the aspect ratio to your preference
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: daysList.length,
      itemBuilder: (context, index) {
        bool isSelected = bloc.selectedTime == index;

        return GestureDetector(
          onTap: () {
            bloc.add(GetSlotByIdUserEvent(index + 1));
          },
          child: Chip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${daysList[index].from}:${daysList[index].to}',
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