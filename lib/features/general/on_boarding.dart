import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:osama_consul/core/utils/assets.dart';

import '../../config/app_routes.dart';
import '../../core/cache/shared_prefrence.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushReplacementNamed(context, Routes.signUp);
  }

  Widget _buildImage(String assetName) {
    return ClipOval(
      child: Image.asset(
        assetName,
        width: 350.w,
        height: 350.w,
        fit: BoxFit.cover,
      ),
    );
  }

  Future<void> setNotFirstTime() async {
    await UserPreferences.enterFirstTime();
  }

  @override
  void initState() {
    setNotFirstTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 16.h),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Schedule Meetings",
          body: "Easily set up consultations at times that work for you.",
          image: _buildImage(Assets.onboarding1),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Chat with Osama Monir",
          body:
              "Receive personalized advice and support from Osama Monir through our chat feature.",
          image: _buildImage(Assets.onboarding1),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Discover Solutions",
          body:
              "Find tailored solutions to your emotional and mental health needs.",
          image: _buildImage(Assets.onboarding1),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Join Our Community",
          body:
              "Connect with others on a similar journey and share your experiences.",
          image: _buildImage(Assets.onboarding1),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      next: const Icon(Icons.arrow_forward, color: Colors.black),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(16.r),
      controlsPadding: EdgeInsets.fromLTRB(8.0.w, 4.0.h, 8.0.w, 4.0.h),
      dotsDecorator: DotsDecorator(
          size: Size(10.w, 10.h),
          color: const Color(0xFFBDBDBD),
          activeSize: Size(22.w, 10.h),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.r)),
          ),
          activeColor: Colors.black),
    );
  }
}
