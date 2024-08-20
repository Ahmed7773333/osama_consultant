import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/app_strings.dart';
import 'package:osama_consul/core/utils/componetns.dart';

import '../bloc/registraion_bloc.dart';

class PasswordResetPage extends StatefulWidget {
  final RegistraionBloc bloc;
  final int otp;

  PasswordResetPage(this.otp, this.bloc, {Key? key}) : super(key: key);

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController pass = TextEditingController();
  GlobalKey<FormState> keyy = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: BlocBuilder<RegistraionBloc, RegistraionState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.r),
            child: Form(
              key: keyy,
              child: Column(
                children: [
                  Components.customTextField(
                    controller: pass,
                    hint: AppStrings.passwordHint,
                    isPassword: true,
                  ),
                  SizedBox(height: 20.h),
                  Components.fillButton(
                    context,
                    onPressed: () {
                      if (keyy.currentState?.validate() ?? false) {
                        widget.bloc.add(ResetPasswordEvent(
                          widget.bloc.emailForget,
                          pass.text,
                          widget.otp,
                        ));
                      }
                    },
                    text: 'Reset Password',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
