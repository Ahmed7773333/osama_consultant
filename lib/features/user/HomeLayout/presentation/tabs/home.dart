import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:osama_consul/core/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../config/app_routes.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../general/Chat Screen/data/models/chat_model.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String name = '';

  @override
  void initState() {
    setName();
    super.initState();
  }

  void setName() async {
    name = (await UserPreferences.getName())!;
    setState(() {});
  }

  final List<String> texts = [
    'Chat with Osama',
    'About Osama Mounir',
    'Your Requests',
  ];

  final List<IconData> icons = [
    Icons.chat_bubble_outline,
    Icons.info_rounded,
    Icons.request_page_outlined,
  ];

  void navigateToChat() async {
    Navigator.pushNamed(context, Routes.chatScreenAdmin, arguments: {
      'id': ChatModel(
          chatName: (await UserPreferences.getName()) ?? '',
          chatOwner: (await UserPreferences.getEmail()) ?? ''),
      'isadmin': false
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(150.w, 80.h),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.r),
            bottomRight: Radius.circular(25.r),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              '${localizations.welcome} $name!',
              style: AppStyles.welcomeSytle,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 315.w,
              height: 500.h,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset(
                    Assets.slider1,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 50.h,
                    child: Text(
                      'OSAMA MOUNIR',
                      style: AppStyles.redLableStyle.copyWith(fontSize: 44.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: texts.length,
                separatorBuilder: (context, index) => SizedBox(width: 24.h),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        navigateToChat();
                      } else if (index == 1) {
                        Navigator.pushNamed(context, Routes.about);
                      } else if (index == 2) {
                        Navigator.pushNamed(context, Routes.myRequests);
                      }
                    },
                    child: SizedBox(
                      width: 200.w,
                      height: 300.h,
                      child: Card(
                        color: Colors.grey.shade900,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icons[index],
                              size: 32.h,
                              color: AppColors.accent,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              texts[index],
                              style: TextStyle(
                                color: AppColors.accent,
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLinkCard(
                      'YouTube',
                      'Now you can watch the latest episodes...',
                      'youtube.com@/c/OsamaMounirOfficial'), // Link to YouTube
                  SizedBox(height: 20.h),
                  _buildLinkCard(
                      'Social Media',
                      'Follow Osama Mounir on Facebook for the latest updates...',
                      'www.osamamounir.com@/social-media/'), // Link to Facebook
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildLinkCard(String title, String description, String url) {
  return InkWell(
    onTap: () {
      // Handle the navigation or link opening
      launchURL(url);
    },
    child: Card(
      color: Colors.grey.shade900,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyles.redLableStyle.copyWith(fontSize: 22.sp),
            ),
            SizedBox(height: 10.h),
            Text(
              description,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void launchURL(String url) {
  launchUrl(Uri.https(url.split('@').first, url.split('@').last));
}
