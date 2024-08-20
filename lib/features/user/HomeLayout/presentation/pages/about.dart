import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/assets.dart';

class AboutOsama extends StatelessWidget {
  const AboutOsama({super.key});

  final String about =
      'Yes, Osama Monir is a well-known Egyptian media personality, often recognized for his work as a radio host and his discussions about love, relationships, and emotional topics. He gained popularity through his radio shows where he talked about various personal and emotional matters, making him a familiar name in Egyptian media, especially among those who are interested in discussions about love and relationships. His deep voice and empathetic approach have made him a beloved figure for many listeners.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Osama Monir', style: TextStyle(fontSize: 22.sp)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.asset(
                    Assets.slider3,
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
      ),
    );
  }
}
