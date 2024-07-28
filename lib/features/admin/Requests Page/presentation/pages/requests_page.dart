// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:osama_consul/core/utils/get_itt.dart';
import 'package:osama_consul/features/admin/Requests%20Page/presentation/bloc/requests_page_bloc.dart';

import '../../../../../core/utils/app_styles.dart';
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
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: ListView.separated(
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
                    subtitle:
                        Text(convertEgyptTimeToLocal(item.scheduleSlot!.from!)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Icon(
                          Icons.close,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10.h);
              },
              itemCount: RequestsPageBloc.get(context).allRequests.length,
            ),
          );
        },
      ),
    );
  }
}
