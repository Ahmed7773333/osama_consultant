// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/app_styles.dart';
import 'package:osama_consul/core/utils/get_itt.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/add_slot.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/presentation/widgets/time_gridview.dart';

import '../../../../../core/utils/app_strings.dart';
import '../bloc/meetings_control_bloc.dart';
import '../widgets/listview_days.dart';

class MettingsControl extends StatelessWidget {
  const MettingsControl({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MeetingsControlBloc>()
        ..add(GetAllSchedulesEvent())
        ..add(GetScheduleByIdEvent(1)),
      child: BlocConsumer<MeetingsControlBloc, MeetingsControlState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.all(16.r),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppStrings.selectDay,
                        style: AppStyles.greenLableStyle),
                    SizedBox(height: 20.h),
                    daysListView(
                        MeetingsControlBloc.get(context).daysOfWeek,
                        MeetingsControlBloc.get(context),
                        MeetingsControlBloc.get(context).selectedDay),
                    SizedBox(height: 20.h),
                    Text(AppStrings.selectTime,
                        style: AppStyles.greenLableStyle),
                    SizedBox(height: 20.h),
                    gridViewTimes(MeetingsControlBloc.get(context).timesOfDay,
                        MeetingsControlBloc.get(context)),
                    SizedBox(height: 50.h),
                    ElevatedButton(
                      onPressed: () {
                        MeetingsControlBloc.get(context).add(AddSlotEvent(
                            SlotToAdd(
                                MeetingsControlBloc.get(context).selectedDay +
                                    1,
                                '12:00',
                                '13:00')));
                      },
                      child: Text('Add Time to this day',
                          style: TextStyle(fontSize: 20.sp)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is GeetingAllSuccessState) {
          } else if (state is GeetingbyIdSuccessState) {}
        },
      ),
    );
  }
}
