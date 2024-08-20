import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/bloc/home_layout_admin_bloc.dart';

import '../../../../../core/network/check_internet.dart';
import '../../../../../core/utils/app_colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab(this.bloc, {super.key});
  final HomeLayoutAdminBloc bloc;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Manage Your Times',
        'icon': Icons.calendar_month,
        'onTab': () {
          Navigator.pushNamed(context, Routes.manageTimes);
        }
      },
      {
        'title': 'Logout',
        'icon': Icons.login_rounded,
        'onTab': () async {
          bool isConnect = await ConnectivityService().getConnectionStatus();
          if (isConnect) bloc.add(LogoutAdminEvent());
        }
      },
      {
        'title': 'Requests',
        'icon': Icons.request_page,
        'onTab': () {
          Navigator.pushNamed(context, Routes.requestsPage);
        }
      }
    ];

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            homeItem(items[0]['title'], items[0]['icon'], items[0]['onTab']),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                homeItem(
                    items[1]['title'], items[1]['icon'], items[1]['onTab']),
                homeItem(
                    items[2]['title'], items[2]['icon'], items[2]['onTab']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget homeItem(String title, IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColors.secondry,
                size: 85.r,
              ),
              SizedBox(height: 8.h),
              Text(title, style: TextStyle(fontSize: 16.sp)),
            ],
          ),
        ),
      ),
    );
  }
}
