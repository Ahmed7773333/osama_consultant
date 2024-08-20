import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/componetns.dart';
import '../bloc/registraion_bloc.dart';
import 'enter_new_password.dart';

class OtpEntryPage extends StatefulWidget {
  final RegistraionBloc bloc;

  OtpEntryPage(
    this.bloc, {
    Key? key,
  }) : super(key: key);

  @override
  State<OtpEntryPage> createState() => _OtpEntryPageState();
}

class _OtpEntryPageState extends State<OtpEntryPage> {
  final TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter OTP code',
                border: OutlineInputBorder(),
              ),
              controller: otp,
              maxLength: 6,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.h),
            Components.fillButton(
              context,
              onPressed: () {
                // Navigate to the password reset page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PasswordResetPage(int.parse(otp.text), widget.bloc)),
                );
              },
              text: 'Verify OTP',
            ),
          ],
        ),
      ),
    );
  }
}
