// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:osama_consul/core/utils/app_styles.dart';
import 'package:osama_consul/core/utils/get_itt.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/add_slot.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/presentation/widgets/time_gridview.dart';

import '../../../../../core/utils/app_strings.dart';
import '../bloc/meetings_control_bloc.dart';
import '../widgets/listview_days.dart';

class MettingsControl extends StatefulWidget {
  const MettingsControl({super.key});

  @override
  _MettingsControlState createState() => _MettingsControlState();
}

class _MettingsControlState extends State<MettingsControl> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  Future<TimeOfDay?> _selectTime(BuildContext context, String title) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: title,
    );
    return picked;
  }

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
                    gridViewTimesAdmin(
                        MeetingsControlBloc.get(context).timesOfDay,
                        MeetingsControlBloc.get(context)),
                    SizedBox(height: 50.h),
                    ElevatedButton(
                      onPressed: () async {
                        startTime =
                            await _selectTime(context, 'Select Start Time');
                        if (startTime != null) {
                          endTime =
                              await _selectTime(context, 'Select End Time');
                          if (endTime != null) {
                            debugPrint(startTime!.format(context));
                            debugPrint(endTime!.format(context));

                            MeetingsControlBloc.get(context).add(AddSlotEvent(
                                SlotToAdd(
                                    MeetingsControlBloc.get(context)
                                            .selectedDay +
                                        1,
                                    convertTo24HourFormat(
                                        startTime!.format(context)),
                                    convertTo24HourFormat(
                                        endTime!.format(context)))));
                          }
                        }
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

String convertTo24HourFormat(String time) {
  // Parse the input time in 12-hour format
  DateFormat inputFormat = DateFormat.jm();
  DateTime dateTime = inputFormat.parse(time);

  // Format the time to 24-hour format with seconds
  DateFormat outputFormat = DateFormat('HH:mm:ss');
  String formattedTime = outputFormat.format(dateTime);

  return formattedTime;
}
