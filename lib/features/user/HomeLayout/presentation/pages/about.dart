import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/app_colors.dart';
import 'package:osama_consul/core/utils/assets.dart';

class AboutOsama extends StatelessWidget {
  const AboutOsama({super.key});

  final String about =
      '''With a voice so strong and distinct, you can differentiate between all others, Osama Mounir is the number one voiceover artist in all of the middle east, and the most popular Egyptian Radio Host. Voiceovers are what kick started his career in the early nineties, opening doors for him left and right, and it only went up from there. As the famous Dr. of Love we all know today, his ongoing radio show “Ana w Nogoom w Hawak” on Nogoom FM is what gave him the Egyptian Love Guru Persona he has today.
Women and men from all over Egypt call the show waiting for love advice from the wise man with the beautiful voice. Ana w Nogoom w Hawak became very popular and has also been selected by RTL International (the German TV Channel) as one of the four best night Radio shows worldwide, and has also been awarded The Best Radio Show in all of Egypt 15 years in a row, as well as Osama Mounir himself being awarded the best Radio Presenter in Egypt 15 years in a row by local and international universities worldwide, TV stations, Radio shows, local and international festivals. He has also recorded endless political, industrial, and religious documentaries with topics of all sorts. His career later broadened to not only voiceovers and Radio shows, but also to TV programs that involve everything from politics to lifestyle, hosting his own TV shows, and staring in award winning movies. He also hosted the Cairo Film Festival and several other events for Etisalat, Coca-Cola, Pepsi, Pfizer and more. Osama Mounir has also been awarded The Number One Radio Presenter in all of the Middle East two years in a row in 2016 and 2017.  But Osama’s talents don’t just end with his unique voice, acting, and hosting skills. He opened up his own advertising agency in 2014 called Express Media and has been growing everyday since. As the CEO & founder of Express Media, Express Media production, OM Digital &Radio Mahatet Misr, Osama has built a very sold name for himself in the market with a huge and respected database of clientele. Some of his TV programs, shows, and movies he’s starred in) Hekaiat w bene’ishha Hekayat Masriya Kol Leila on Nile Life TV Channel. 90 Minutes on El Mehwar TV El Beit Beitak .''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondry,
      appBar: AppBar(
        backgroundColor: AppColors.secondry,
        title: Text('About Osama Mounir',
            style: TextStyle(fontSize: 22.sp, color: Colors.redAccent)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(
                  Assets.slider2,
                  width: 315.w,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.r,
                      spreadRadius: 5.r,
                    ),
                  ],
                ),
                child: Text(
                  about,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black87,
                    height: 1.5.h,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
