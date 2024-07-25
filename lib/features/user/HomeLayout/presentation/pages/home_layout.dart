import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/get_itt.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/tabs/home.dart';

import '../bloc/homelayout_bloc.dart';
import '../tabs/booking.dart';
import '../tabs/profile.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomelayoutBloc>()
        ..add(GetAllSchedulesUserEvent())
        ..add(GetScheduleByIdUserEvent(1)),
      child: BlocConsumer<HomelayoutBloc, HomelayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          // final HomelayoutBloc bloc = HomelayoutBloc.get(context);
          return Scaffold(
            body: PageView(
              controller: _pageController,
              children: [
                const HomeTab(),
                BookingTab(HomelayoutBloc.get(context)),
                const ProfileTab(),
              ],
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _pageController.jumpToPage(index);
              },
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30.r,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.book,
                    size: 30.r,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 30.r),
                  label: '',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
