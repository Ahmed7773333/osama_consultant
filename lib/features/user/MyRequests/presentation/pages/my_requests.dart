import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:osama_consul/core/utils/app_styles.dart';
import 'package:osama_consul/core/utils/assets.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/componetns.dart';
import '../../../../../core/utils/get_itt.dart';
import '../cubit/myrequests_cubit.dart';
import '../widgets/functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyRequests extends StatelessWidget {
  const MyRequests({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => sl<MyrequestsCubit>()..getAllRequests(),
      child: BlocConsumer<MyrequestsCubit, MyrequestsState>(
        listener: (context, state) {
          if (state is SuccessRequestTokenCardPaymentState) {
            Navigator.pushNamed(context, Routes.visaScreen, arguments: {
              'cubit': MyrequestsCubit.get(context),
              'id': state.id
            });
          }
        },
        builder: (context, state) {
          if (state is LoadingMyRequestsState &&
              MyrequestsCubit.get(context).allRequests.isEmpty) {
            return Scaffold(appBar: AppBar(), body: Components.shrimList());
          } else if (MyrequestsCubit.get(context).allRequests.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text(localizations.myRequests),
              ),
              body: Components.reloadPull(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    RequestModel item =
                        MyrequestsCubit.get(context).allRequests[index];
                    DateTime time = DateTime.parse(item.meetingDate!);
                    String abbreviatedMonth =
                        DateFormat('MMM', localizations.localeName)
                            .format(time)
                            .toUpperCase();
                    return Card(
                      elevation: 20,
                      child: ListTile(
                        onTap: () {
                          MyrequestsCubit.get(context).setRequest(item);
                          Navigator.pushNamed(context, Routes.paymentScren,
                              arguments: {
                                'cubit': MyrequestsCubit.get(context)
                              });
                        },
                        leading: Container(
                          height: 70.h,
                          width: 50.w,
                          decoration: ShapeDecoration(
                              color: AppColors.secondry,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)))),
                          child: Center(
                            child: Text(
                              '${time.day}\n$abbreviatedMonth',
                              style: AppStyles.whiteLableStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        title: Text(DateFormat('EEEE', localizations.localeName)
                            .format(time)),
                        subtitle: Text(
                            convertEgyptTimeToLocal(item.scheduleSlot!.from!)),
                        trailing: Text(
                          item.meetingStatus ?? '',
                          style: AppStyles.titleStyle
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10.h);
                  },
                  itemCount: MyrequestsCubit.get(context).allRequests.length,
                ),
                onLoad: () {
                  MyrequestsCubit.get(context).getAllRequests();
                },
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(localizations.myRequests),
              ),
              body: Center(
                child: Image.asset(
                  Assets.empty,
                  width: 400.w,
                  height: 360.h,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
