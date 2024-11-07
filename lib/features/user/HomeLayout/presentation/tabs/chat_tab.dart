import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../../core/utils/app_animations.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../general/Chat Screen/data/models/chat_model.dart';
import '../../../../general/Chat Screen/presentation/pages/buy_consultants.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    void navigateToChat() async {
      Navigator.pushNamed(context, Routes.chatScreenAdmin, arguments: {
        'id': ChatModel(
            chatName: (await UserPreferences.getName()) ?? '',
            chatOwner: (await UserPreferences.getEmail()) ?? ''),
        'isadmin': false
      });
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
                      left: 10.w,
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
                      left: 160.w,
                      child: Text(
                        'Emotional Wellness',
                        style: AppStyles.titleStyle
                            .copyWith(color: Colors.redAccent),
                      ),
                    ),
                    Positioned(
                      top: 40.h,
                      left: 160.w,
                      child: Text(
                        'Get support from experienced\nconsultants who specialize\nin emotional wellness. Whether\nyou need help with stress, anxiety,\nor personal growth, we are\nhere to listen and guide you.',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150.h,
                      left: 160.w,
                      child: Text(
                        'Connect with your consultant\nanytime. Share your thoughts\nthrough text or easily record\nand send voice messages.',
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
                    SizedBox(width: 10.w),
                    // Text and button section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Buy Consultants Credit',
                            style: AppStyles.redLableStyle,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Charge the consultant’s wallet to\nget exclusive support and services.',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey[300],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to the payment or charging screen
                              Navigator.push(
                                  context, TopRouting(BuyConsultants()));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text('Charge Wallet',
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
