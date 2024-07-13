import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_styles.dart';
import 'booking tabs/chat_booking.dart';
import 'booking tabs/meeting_booking.dart';

class BookingTab extends StatefulWidget {
  const BookingTab({super.key});

  @override
  State<BookingTab> createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  int curruntIndex = 0;
  final List<Widget> pages = [
    const MeetingBooking(),
    const ChatBooking(),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: curruntIndex);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  List<String> ls = ['Book a Meeting', 'Book a chat'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          DefaultTabController(
            length: 2,
            child: SizedBox(
              width: 360.w,
              height: 44.h,
              child: TabBar(
                dividerColor: const Color(0x00FFFFF0),
                controller: _tabController,
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.black,
                indicatorWeight: 3,
                labelStyle: AppStyles.smallStyle.copyWith(fontSize: 16.sp),
                tabs: ls
                    .map((e) => Tab(
                          height: 30,
                          child: Center(child: Text(e)),
                        ))
                    .toList(),
              ),
            ),
          ),
          SizedBox(
            height: 670.h,
            width: double.infinity,
            child: PageView(
              controller: _pageController,
              children: pages,
              onPageChanged: (index) {
                _tabController.animateTo(index);
              },
            ),
          ),
        ],
      )),
    );
  }
}
