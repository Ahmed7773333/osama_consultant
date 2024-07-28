// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:osama_consul/core/utils/app_strings.dart';
import 'package:osama_consul/core/utils/app_styles.dart';

import '../../../../../../config/app_routes.dart';
import '../../../../../../core/cache/shared_prefrence.dart';
import '../../../../../admin/Home Layout Admin/data/models/chat_model.dart';
import '../../../../../admin/Meetings Control/data/models/all_schedules_model.dart';
import '../../../../MyRequests/presentation/widgets/functions.dart';
import '../../bloc/homelayout_bloc.dart';
import '../../widgets/gridview_times.dart';
import '../../widgets/listview_days.dart';

class MeetingBooking extends StatefulWidget {
  const MeetingBooking(this.bloc, {super.key});
  final HomelayoutBloc bloc;

  @override
  _MeetingBookingState createState() => _MeetingBookingState();
}

class _MeetingBookingState extends State<MeetingBooking> {
  void navigateToChat() async {
    Navigator.pushNamed(context, Routes.chatScreenAdmin, arguments: {
      'id': ChatModel(
          chatName: (await UserPreferences.getName()) ?? '',
          chatOwner: (await UserPreferences.getEmail()) ?? ''),
      'isadmin': false
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book a Meeting',
          style: AppStyles.greenLableStyle.copyWith(fontSize: 25.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppStrings.selectDay, style: AppStyles.greenLableStyle),
              SizedBox(height: 20.h),
              daysListView(
                  widget.bloc.daysOfWeek, widget.bloc, widget.bloc.selectedDay),
              SizedBox(height: 20.h),
              Text(AppStrings.selectTime, style: AppStyles.greenLableStyle),
              SizedBox(height: 20.h),
              gridViewTimesUser(widget.bloc.timesOfDay, widget.bloc),
              if (widget.bloc.slotDetails != null)
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.h),
                      Text(AppStrings.slotDetails,
                          style: AppStyles.greenLableStyle),
                      SizedBox(height: 20.h),
                      buildSlotCard(widget.bloc.slotDetails!),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          widget.bloc.add(ConfirmBookingEvent());
                        },
                        child: Text('Send a Request',
                            style: TextStyle(fontSize: 20.sp)),
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: Text('OR', style: AppStyles.greenLableStyle),
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: navigateToChat,
                        child: Text('Proceed to Chat',
                            style: TextStyle(fontSize: 20.sp)),
                      ),
                    ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSlotCard(SlotModel slot) {
    DateTime time = DateTime.parse(getDateForDay(slot.scheduleId!));
    String abbreviatedMonth = DateFormat('MMM').format(time).toUpperCase();
    return Card(
      elevation: 20,
      child: ListTile(
        leading: Container(
          height: 70.h,
          width: 50.w,
          decoration: ShapeDecoration(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.r)))),
          child: Center(
            child: Text(
              ' ${time.day}\n$abbreviatedMonth',
              style: AppStyles.whiteLableStyle,
            ),
          ),
        ),
        title: Text(DateFormat('EEEE').format(time)),
        subtitle: Text(convertEgyptTimeToLocal(slot.from!)),
      ),
    );
  }
}
