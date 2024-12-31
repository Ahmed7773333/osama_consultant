import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/componetns.dart';
import 'package:osama_consul/core/utils/get_itt.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/tabs/chat_tab.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/tabs/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../config/app_routes.dart';
import '../bloc/homelayout_bloc.dart';
import '../tabs/profile.dart';
import '../tabs/quote.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({this.page = 0, super.key});
  final int page;
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.page;
    _pageController = PageController(
      initialPage: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => sl<HomelayoutBloc>()..add(GetQuotesEvent()),
      child: BlocConsumer<HomelayoutBloc, HomelayoutState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.home,
              (Route<dynamic> route) => false,
            );
          } else if (state is LogoutLoadingState) {
            Components.circularProgressHeart(context);
          }
        },
        builder: (context, state) {
          // final HomelayoutBloc bloc = HomelayoutBloc.get(context);
          return Scaffold(
            body: PageView(
              controller: _pageController,
              children: [
                HomeTab(bloc: HomelayoutBloc.get(context)),
                const ChatTab(),
                Quote(HomelayoutBloc.get(context)),
                ProfileTab(HomelayoutBloc.get(context)),
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
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30.r,
                    color: Colors.white,
                  ),
                  label: localizations.home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_rounded,
                    size: 30.r,
                    color: Colors.white,
                  ),
                  label: localizations.chat,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.question_answer,
                    size: 30.r,
                    color: Colors.white,
                  ),
                  label: localizations.quote,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 30.r,
                    color: Colors.white,
                  ),
                  label: localizations.profile,
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
