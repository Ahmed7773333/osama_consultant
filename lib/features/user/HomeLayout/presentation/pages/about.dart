import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/app_colors.dart';
import 'package:osama_consul/core/utils/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AboutOsama extends StatelessWidget {
  const AboutOsama({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondry,
      appBar: AppBar(
        backgroundColor: AppColors.secondry,
        title: Text( AppLocalizations.of(context)!.aboutOsama,
            style: TextStyle(fontSize: 22.sp, color: Color(0xffc02829))),
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
                  AppLocalizations.of(context)!.about_content,
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
