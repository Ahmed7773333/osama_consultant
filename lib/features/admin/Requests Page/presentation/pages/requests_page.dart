// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:osama_consul/core/cache/notification_service.dart';
import 'package:osama_consul/core/utils/app_animations.dart';
import 'package:osama_consul/core/utils/get_itt.dart';
import 'package:osama_consul/features/admin/Requests%20Page/presentation/bloc/requests_page_bloc.dart';
import 'package:osama_consul/features/admin/Requests%20Page/presentation/pages/request_details.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/componetns.dart';
import '../../../../general/Meeting Screen/meeting_screen.dart';
import '../../../../user/MyRequests/data/models/all_meeting_response.dart';
import '../../../../user/MyRequests/presentation/widgets/functions.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<RequestsPageBloc>()..add(GetAllRequestsAdminEvent()),
      child: BlocConsumer<RequestsPageBloc, RequestsPageState>(
        listener: (context, state) {
          if (state is SuccessGenerateRtcTokenState) {
            Navigator.push(
                context,
                RightRouting(MeetingScreen(
                    0,
                    '007eJxTYJA3uu+U+uUuWzfnuacVW/1i7we7dHFc/CyxkCm3+n3LqT4FBjPTlFTLRItUUwvTZJPEZFOLFMNEA/OkZCCZYplimXziyJG0hkBGhnP73jEzMkAgiM/GUJJaXFJSycAAAPVDIyw=',
                    'testty')));
          }
        },
        builder: (context, state) {
          if (RequestsPageBloc.get(context).allRequests.isEmpty &&
              state is LoadingAllRequestsState) {
            return Scaffold(
              appBar: AppBar(),
              body: Components.shrimList(),
            );
          }
          return Scaffold(
            appBar: AppBar(),
            body: Components.reloadPull(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  RequestModel item =
                      RequestsPageBloc.get(context).allRequests[index];
                  DateTime time = DateTime.parse(item.meetingDate!);
                  String abbreviatedMonth =
                      DateFormat('MMM').format(time).toUpperCase();
                  return Card(
                    elevation: 20,
                    child: ListTile(
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
                      subtitle: Text(
                          convertEgyptTimeToLocal(item.scheduleSlot!.from!)),
                      trailing: item.meetingStatus == 'pending'
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    RequestsPageBloc.get(context)
                                        .add(AcceptRequestEvent(item.id!));
                                    NotificationService().pushNotification(
                                        'Your Request Status',
                                        'The admin accepted your Request',
                                        '',
                                        id: item.userId);
                                  },
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                IconButton(
                                  onPressed: () {
                                    RequestsPageBloc.get(context)
                                        .add(RejecetRequestEvent(item.id!));
                                    NotificationService().pushNotification(
                                        'Your Request Status',
                                        'The admin Rejeceted your Request',
                                        '',
                                        id: item.userId);
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: AppColors.secondry,
                                  ),
                                )
                              ],
                            )
                          : item.meetingStatus == 'awaiting-payment'
                              ? Text('Wating for payment')
                              : IconButton(
                                  onPressed: () {
                                    RequestsPageBloc.get(context)
                                        .add(SetRequestAdminEvent(item));
                                    Navigator.push(
                                        context,
                                        RightRouting(RequestAdminDetails(
                                            RequestsPageBloc.get(context))));
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.secondry,
                                  )),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10.h);
                },
                itemCount: RequestsPageBloc.get(context).allRequests.length,
              ),
              onLoad: () {
                RequestsPageBloc.get(context).add(GetAllRequestsAdminEvent());
              },
            ),
          );
        },
      ),
    );
  }
}
