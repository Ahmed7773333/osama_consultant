import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/widgets/youtube_widget.dart';
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
    'Let\'s Chat',
    'About Osama Monir',
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
            // Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 200.h,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: [
                Image.asset(Assets.slider3),
                Image.asset(Assets.slider2),
                Image.asset(Assets.slider1),
              ],
            ),

            Divider(color: Colors.grey),
            SizedBox(
              height: 168.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return YouTubeThumbnailLink(
                    videoId: videoIds[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 1.w);
                },
                itemCount: videoIds.length,
              ),
            ),
            Divider(color: Colors.grey),
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
                              color: Colors.white,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              texts[index],
                              style: TextStyle(
                                color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
