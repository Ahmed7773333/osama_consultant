// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:osama_consul/features/general/Registraion/presentation/bloc/registraion_bloc.dart';

import 'enter_otp.dart';

class EmailEntryPage extends StatefulWidget {
  final RegistraionBloc bloc;
  const EmailEntryPage(
    this.bloc, {
    Key? key,
  }) : super(key: key);

  @override
  State<EmailEntryPage> createState() => _EmailEntryPageState();
}

class _EmailEntryPageState extends State<EmailEntryPage> {
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                widget.bloc.add(ForgetPasswordEvent(email.text));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtpEntryPage(widget.bloc)),
                );
              },
              child: Center(child: Text('Send OTP')),
            ),
          ],
        ),
      ),
    );
  }
}
