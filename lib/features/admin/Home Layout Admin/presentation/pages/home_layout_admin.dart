// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/get_itt.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/bloc/home_layout_admin_bloc.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/pages/chat_tab.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/pages/home_tab.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/componetns.dart';

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
      create: (context) => sl<HomeLayoutAdminBloc>()..add(GetAllChatsEvent()),
      child: BlocConsumer<HomeLayoutAdminBloc, HomeLayoutAdminState>(
        listener: (context, state) {
          if (state is LogoutAdminSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.signUp,
              (Route<dynamic> route) => false,
            );
          } else if (state is LogoutAdminLoadingState ||
              state is AddMemberLoadingState ||
              state is AddQuoteLoadingState) {
            Components.circularProgressHeart(context);
          } else if (state is AddMemberSuccessState ||
              state is AddQuoteSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: PageView(
              controller: _pageController,
              children: [
                HomeTab(HomeLayoutAdminBloc.get(context)),
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
              selectedItemColor: AppColors.secondry,
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
