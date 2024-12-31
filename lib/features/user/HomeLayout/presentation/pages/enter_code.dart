import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/api/api_manager.dart';
import 'package:osama_consul/core/utils/componetns.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../../core/utils/app_animations.dart';
import 'home_layout.dart';

class EnterCode extends StatefulWidget {
  @override
  _EnterCodeState createState() => _EnterCodeState();
}

class _EnterCodeState extends State<EnterCode> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              Navigator.pushReplacement(
                  context, BottomRouting(HomeLayout(page: 3)));
            },
            icon: Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24.sp,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await ApiManager().postDataa(EndPoints.enterCode, body: {
                  'code': _controller.text,
                  'user_id': await UserPreferences.getId(),
                },data: {
              'Authorization': 'Bearer ${await UserPreferences.getToken()}'
            },).then((r) async {
                  if (r.statusCode == 201) {
                    await UserPreferences.setConsultantCount(r.data['counter']);
                    Navigator.pushReplacement(
                        context, BottomRouting(HomeLayout(page: 3)));
                  } else {
                    Components.showMessage(context,
                        content: 'Code Not Found',
                        icon: Icons.error,
                        color: Colors.red);
                  }
                });
              },
              child: Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}
