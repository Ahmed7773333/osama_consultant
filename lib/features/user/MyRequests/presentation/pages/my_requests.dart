// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/app_routes.dart';

class MyRequests extends StatelessWidget {
  const MyRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 20,
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, Routes.paymentScren);
              },
              title: Text('Request ${index + 1}'),
              subtitle: const Text('day:time'),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 10.h);
        },
        itemCount: 3,
      ),
    );
  }
}
