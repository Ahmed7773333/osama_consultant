import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/config/app_routes.dart';

class ChargeWalletMenu extends StatelessWidget {
  const ChargeWalletMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        SizedBox(width: 18.w),
        Icon(Icons.payment, color: Colors.white),
        SizedBox(width: 8.w),
        DropdownButton<String>(
          items: [
            DropdownMenuItem(
              value: "quote",
              child: Text(localizations.sub),
            ),
            DropdownMenuItem(
              value: "charge_wallet",
              child: Text(localizations.buyTicket),
            ),
          ],
          onChanged: (value) {
            if (value == "quote") {
              Navigator.pushNamed(context, Routes.paymentMethods, arguments: {
                'is_ticket': false,
              });
            } else if (value == "charge_wallet") {
              Navigator.pushNamed(context, Routes.paymentMethods, arguments: {
                'is_ticket': true,
              });
            }
          },
          hint: Text(
            localizations.chargeWallet,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
