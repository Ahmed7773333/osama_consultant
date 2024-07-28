// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:osama_consul/core/utils/app_styles.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/utils/get_itt.dart';
import '../cubit/myrequests_cubit.dart';
import '../widgets/functions.dart';

class MyRequests extends StatelessWidget {
  const MyRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MyrequestsCubit>()..getAllRequests(),
      child: BlocConsumer<MyrequestsCubit, MyrequestsState>(
        listener: (context, state) {
          if (state is SuccessRequestTokenCardPaymentState) {
            Navigator.pushNamed(context, Routes.visaScreen,
                arguments: {'cubit': MyrequestsCubit.get(context)});
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Requests'),
            ),
            body: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                RequestModel item =
                    MyrequestsCubit.get(context).allRequests[index];
                DateTime time = DateTime.parse(item.meetingDate!);
                String abbreviatedMonth =
                    DateFormat('MMM').format(time).toUpperCase();
                return Card(
                  elevation: 20,
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.paymentScren,
                          arguments: {
                            'request': item,
                            'cubit': MyrequestsCubit.get(context)
                          });
                    },
                    leading: Container(
                      height: 70.h,
                      width: 50.w,
                      decoration: ShapeDecoration(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.r)))),
                      child: Center(
                        child: Text(
                          ' ${time.day}\n$abbreviatedMonth',
                          style: AppStyles.whiteLableStyle,
                        ),
                      ),
                    ),
                    title: Text(DateFormat('EEEE').format(time)),
                    subtitle:
                        Text(convertEgyptTimeToLocal(item.scheduleSlot!.from!)),
                    trailing: Text(
                      item.meetingStatus ?? '',
                      style: AppStyles.titleStyle.copyWith(color: Colors.black),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10.h);
              },
              itemCount: MyrequestsCubit.get(context).allRequests.length,
            ),
          );
        },
      ),
    );
  }
}
