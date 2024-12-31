import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/bloc/home_layout_admin_bloc.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/network/check_internet.dart';
import '../../../../../core/utils/app_colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab(this.bloc, {super.key});
  final HomeLayoutAdminBloc bloc;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Add Team Members',
        'icon': Icons.person,
        'onTab': () {
          Navigator.pushNamed(context, Routes.addMembers,arguments: {'bloc':bloc});
        }
      },
      {
        'title': 'push notification',
        'icon': Icons.notification_add,
        'onTab': () {
          Navigator.pushNamed(context, Routes.pushNotification,arguments: {'bloc':bloc});
        }
      },
      {
        'title': 'Generate Code',
        'icon': Icons.code,
        'onTab': () {
          Navigator.pushNamed(context, Routes.generateCode);
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
    ];

    return Scaffold(
      body: Center(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return homeItem(items[index]['title'], items[index]['icon'],
                    items[index]['onTab']);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10.h,
                );
              },
              itemCount: items.length)),
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
