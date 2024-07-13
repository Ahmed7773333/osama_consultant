// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/features/Home%20Layout%20Admin/presentation/bloc/home_layout_admin_bloc.dart';
import 'package:osama_consul/features/Home%20Layout%20Admin/presentation/pages/chat_tab.dart';

import '../../../../core/cache/shared_prefrence.dart';

class HomeLayoutAdmin extends StatefulWidget {
  const HomeLayoutAdmin(this.i, {super.key});
  final int? i;
  @override
  State<HomeLayoutAdmin> createState() => _HomeLayoutAdminState();
}

class _HomeLayoutAdminState extends State<HomeLayoutAdmin> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.i ?? 0;
    _pageController = PageController(
      initialPage: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutAdminBloc()..add(GetChatsEvent()),
      child: BlocConsumer<HomeLayoutAdminBloc, HomeLayoutAdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: PageView(
              controller: _pageController,
              children: [
                Center(
                  child: FilledButton(
                      onPressed: () async {
                        await removeUserData();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.signUp,
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text("Log out")),
                ),
                const ChatTab(),
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
                    Icons.chat_outlined,
                    size: 30.r,
                  ),
                  activeIcon: Icon(
                    Icons.chat,
                    size: 30.r,
                  ),
                  label: "",
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
