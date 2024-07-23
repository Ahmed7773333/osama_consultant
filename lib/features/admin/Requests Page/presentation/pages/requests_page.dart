// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 20,
            child: ListTile(
              onTap: () async {},
              title: Text('Request ${index + 1}'),
              subtitle: const Text('day:time'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
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
        itemCount: 3,
      ),
    );
  }
}
