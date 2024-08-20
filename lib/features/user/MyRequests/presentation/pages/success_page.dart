import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/cubit/myrequests_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentCompletedPage extends StatelessWidget {
  const PaymentCompletedPage(this.cubit, {super.key});
  final MyrequestsCubit cubit;
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
