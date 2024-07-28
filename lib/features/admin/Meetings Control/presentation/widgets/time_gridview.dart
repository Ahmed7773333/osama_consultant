import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/all_schedules_model.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/presentation/bloc/meetings_control_bloc.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../user/MyRequests/presentation/widgets/functions.dart';

Widget gridViewTimesAdmin(List<SlotModel> daysList, MeetingsControlBloc bloc) {
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
            bloc.add(GetSlotByIdEvent(index));
          },
          child: Chip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${convertEgyptTimeToLocal(daysList[index].from!)}:${convertEgyptTimeToLocal(daysList[index].to!)}',
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
