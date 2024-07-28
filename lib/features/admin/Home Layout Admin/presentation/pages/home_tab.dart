// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/bloc/home_layout_admin_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab(this.bloc, {super.key});
  final HomeLayoutAdminBloc bloc;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {
        'title': 'Manage Your Times',
        'icon': Icons.calendar_month,
        'onTab': () {
          Navigator.pushNamed(context, Routes.manageTimes);
        }
      },
      {'title': 'Medical File', 'icon': Icons.file_copy, 'onTab': () {}},
      {
        'title': 'Ask your doctor',
        'icon': Icons.local_hospital,
        'onTab': () async {
          bloc.add(LogoutAdminEvent());
        }
      },
      {'title': 'Customer Service', 'icon': Icons.call, 'onTab': () {}},
      {
        'title': 'Account Settings',
        'icon': Icons.settings,
        'onTab': () {
          Navigator.pushNamed(context, Routes.settings);
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
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.95,
              mainAxisSpacing: 24.h,
              crossAxisSpacing: 11.w),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return homeItem(items[index]['title'], items[index]['icon'],
                items[index]['onTab']);
          }),
    );
  }

  Widget homeItem(String title, IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.green,
              size: 85.r,
            ),
            SizedBox(height: 8.h),
            Text(title, style: TextStyle(fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }
}
