// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:osama_consul/core/utils/app_styles.dart';
import 'package:osama_consul/core/utils/componetns.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/network/check_internet.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../admin/Meetings Control/data/models/all_schedules_model.dart';
import '../../../MyRequests/presentation/widgets/functions.dart';
import '../bloc/homelayout_bloc.dart';
import '../widgets/gridview_times.dart';
import '../widgets/listview_days.dart';

class MeetingBooking extends StatefulWidget {
  const MeetingBooking(this.bloc, {super.key});
  final HomelayoutBloc bloc;

  @override
  _MeetingBookingState createState() => _MeetingBookingState();
}

class _MeetingBookingState extends State<MeetingBooking> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          localizations.bookAMeeting,
        ),
      ),
      body: Components.reloadPull(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 275.h,
                width: 375.w,
                child: Card(
                  elevation: 5,
                  child: Stack(
                    children: [
                      // Image section
                      Positioned(
                        top: 0,
                        left: 10.w,
                        child: Image.asset(
                          Assets.slider1,
                          fit: BoxFit.cover,
                          height: 250.h,
                          width: 140.w,
                        ),
                      ),

                      // Title and description section
                      Positioned(
                        top: 15.h,
                        left: 160.w,
                        child: Text(
                          'Emotional Wellness',
                          style: AppStyles.titleStyle
                              .copyWith(color: Colors.redAccent),
                        ),
                      ),
                      Positioned(
                        top: 40.h,
                        left: 160.w,
                        child: Text(
                          'Get support from experienced\nconsultants who specialize\nin emotional wellness. Whether\nyou need help with stress, anxiety,\nor personal growth, we are\nhere to listen and guide you.',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 150.h,
                        left: 160.w,
                        child: Text(
                          'Engage with your consultant\nface-to-face anytime. Start a\nvideo call and get the support\nyou need instantly.',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: widget.bloc.daysOfWeek.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(localizations.selectDay,
                              style: AppStyles.redLableStyle),
                          SizedBox(height: 10.h),
                          daysListView(widget.bloc.daysOfWeek, widget.bloc,
                              widget.bloc.selectedDay),
                          SizedBox(height: 10.h),
                          Text(localizations.selectTime,
                              style: AppStyles.redLableStyle),
                          SizedBox(height: 10.h),
                          gridViewTimesUser(
                              widget.bloc.timesOfDay, widget.bloc),
                          widget.bloc.slotDetails != null
                              ? Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                      SizedBox(height: 10.h),
                                      Text(localizations.slotDetails,
                                          style: AppStyles.redLableStyle),
                                      SizedBox(height: 10.h),
                                      buildSlotCard(widget.bloc.slotDetails!),
                                      SizedBox(height: 10.h),
                                      ElevatedButton(
                                        onPressed: () async {
                                          bool isConnect =
                                              await ConnectivityService()
                                                  .getConnectionStatus();
                                          if (isConnect)
                                            widget.bloc
                                                .add(ConfirmBookingEvent());
                                        },
                                        child: Text(localizations.sendARequest,
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                color: Colors.white)),
                                      ),
                                      SizedBox(height: 50.h),
                                    ])
                              : Center(
                                  child: Text(localizations.noAvailableTimes))
                        ],
                      )
                    : Center(child: Text(localizations.checkYourConnection)),
              ),
            ],
          ),
        ),
        onLoad: () {
          widget.bloc.add(GetAllSchedulesUserEvent());
          widget.bloc.add(GetScheduleByIdUserEvent(1));
        },
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
              color: AppColors.secondry,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.r)))),
          child: Center(
            child: Text(
              '${time.day}\n$abbreviatedMonth',
              style: AppStyles.whiteLableStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        title: Text(DateFormat('EEEE').format(time)),
        subtitle: Text(convertEgyptTimeToLocal(slot.from!)),
      ),
    );
  }
}
