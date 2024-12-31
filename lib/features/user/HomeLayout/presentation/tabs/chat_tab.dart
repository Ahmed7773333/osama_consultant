import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../../core/network/check_internet.dart';
import '../../../../../core/network/firebase_helper.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/componetns.dart';
import '../../../../general/Chat Screen/data/models/chat_model.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    void navigateToChat() async {
      bool isConnect = await ConnectivityService().getConnectionStatus();
      if (isConnect) {
        Navigator.pushNamed(context, Routes.chatScreenAdmin, arguments: {
          'id': ChatModel(
              chatName: (await UserPreferences.getName()) ?? '',
              chatOwner: (await UserPreferences.getEmail()) ?? '',
              isOpened: (await FirebaseHelper()
                  .getIsOpened((await UserPreferences.getEmail()) ?? ''))),
          'isadmin': false
        });
      } else {
        Components.showMessage(context,
            content: 'No Internet', icon: Icons.error, color: Colors.red);
      }
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 300.h,
              width: 375.w,
              child: Card(
                elevation: 5,
                child: Stack(
                  children: [
                    // Image section
                    Positioned(
                      top: 0,
                      left: localizations.localeName == 'en' ? 10.w : null,
                      right: localizations.localeName == 'ar' ? 10.w : null,
                      child: Image.asset(
                        Assets.slider2,
                        fit: BoxFit.cover,
                        height: 250.h,
                        width: 140.w,
                      ),
                    ),

                    // Title and description section
                    Positioned(
                      top: 15.h,
                      left: localizations.localeName == 'en' ? 160.w : null,
                      right: localizations.localeName == 'ar' ? 160.w : null,
                      child: Text(
                        localizations.emotionalWellness,
                        style: AppStyles.titleStyle
                            .copyWith(color: Color(0xffc02829)),
                      ),
                    ),
                    Positioned(
                      top: 40.h,
                      left: localizations.localeName == 'en' ? 160.w : null,
                      right: localizations.localeName == 'ar' ? 160.w : null,
                      child: Text(
                        localizations.emotionalSupportDescription,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150.h,
                      left: localizations.localeName == 'en' ? 160.w : null,
                      right: localizations.localeName == 'ar' ? 160.w : null,
                      child: Text(
                        localizations.connectWithConsultant,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: navigateToChat,
              child: Text(localizations.proceedToChat,
                  style: TextStyle(fontSize: 20.sp, color: Colors.white)),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 150.h,
              width: 375.w,
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                    // Image section
                    Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Image.asset(
                        Assets.card, // Add the path to your image asset
                        fit: BoxFit.cover,
                        height: 100.h,
                        width: 100.w,
                      ),
                    ),

                    // Text and button section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localizations.buyConsultantsCredit,
                            style: AppStyles.redLableStyle,
                          ),
                          Text(
                            localizations.chargeWalletDescription,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey[300],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to the payment or charging screen
                              Navigator.pushNamed(
                                  context, Routes.paymentMethods);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(localizations.chargeWallet,
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
