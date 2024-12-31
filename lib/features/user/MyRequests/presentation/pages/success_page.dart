import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';
import 'package:osama_consul/core/utils/app_animations.dart';
import 'package:osama_consul/features/general/Chat%20Screen/data/models/chat_model.dart';
import 'package:osama_consul/features/general/Chat%20Screen/presentation/pages/chat_screen.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/cubit/myrequests_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../config/app_routes.dart';

class PaymentCompletedPage extends StatelessWidget {
  const PaymentCompletedPage(this.cubit, this.isTicket,
      {super.key, this.consultant});
  final MyrequestsCubit cubit;
  final int? consultant;
  final bool? isTicket;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              String id = await UserPreferences.getEmail() ?? '';
              String name = await UserPreferences.getName() ?? '';
              if (isTicket ?? true) {
                Navigator.pushReplacement(
                    context,
                    LeftRouting(ChatScreen(
                        ChatModel(chatOwner: id, chatName: name), false)));
              } else
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.homeLayout,
                  (Route<dynamic> route) => false, // Removes all routes
                );
            },
            icon: Icon(Icons.arrow_back_ios_rounded)),
        title: Text(localizations.paymentStatus),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 150.r,
            ),
            SizedBox(height: 20.h),
            Text(
              localizations.paymentCompleted,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentDeclinedPage extends StatelessWidget {
  const PaymentDeclinedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.paymentStatus),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.cancel_outlined,
              color: Colors.red,
              size: 150.r,
            ),
            SizedBox(height: 20.h),
            Text(
              localizations.paymentDeclined,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
