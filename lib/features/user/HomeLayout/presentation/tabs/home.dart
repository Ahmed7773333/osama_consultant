import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:osama_consul/core/utils/app_colors.dart';
import 'package:osama_consul/core/utils/componetns.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/bloc/homelayout_bloc.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../config/app_routes.dart';
import '../../../../../core/network/check_internet.dart';
import '../../../../../core/network/firebase_helper.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../general/Chat Screen/data/models/chat_model.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({this.bloc, super.key});
  final HomelayoutBloc? bloc;
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String name = '';
  String token = '';

  @override
  void initState() {
    setName();
    super.initState();
  }

  void setName() async {
    name = (await UserPreferences.getName()) ?? '';
    token = (await UserPreferences.getToken()) ?? '';

    setState(() {});
  }

  void navigateToChat() async {
    bool isConnect = await ConnectivityService().getConnectionStatus();
    if (isConnect) {
      Navigator.pushNamed(context, Routes.chatScreenAdmin, arguments: {
        'id': ChatModel(
            chatName: (await UserPreferences.getName()) ?? '',
            chatOwner: (await UserPreferences.getEmail()) ?? '',
            isOpened: await FirebaseHelper()
                .getIsOpened((await UserPreferences.getEmail()) ?? '')),
        'isadmin': false
      });
    } else
      Components.showMessage(context,
          content: 'No Internet', icon: Icons.error, color: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final List<DrawerItem> items = [
      DrawerItem(
        title: localizations.chatWithOsama,
        icon: Icons.chat,
        onTap: () {
          if (token.isEmpty) {
            Components.showMessage(context,
                content: localizations.youHaveRegister,
                icon: Icons.error,
                color: AppColors.accent);
          } else {
            navigateToChat();
          }
        },
      ),
      DrawerItem(
          title: localizations.aboutOsama,
          icon: Icons.info,
          onTap: () {
            Navigator.pushNamed(context, Routes.about);
          }),
      DrawerItem(
          title: localizations.chargeWallet,
          icon: Icons.wallet,
          onTap: () {
            if (token.isEmpty) {
              Components.showMessage(context,
                  content: localizations.youHaveRegister,
                  icon: Icons.error,
                  color: AppColors.accent);
            } else {
              Navigator.pushNamed(context, Routes.paymentMethods);
            }
          }),
      if (token.isNotEmpty)
        DrawerItem(
            title: localizations.signOut,
            icon: Icons.logout,
            onTap: () {
              widget.bloc!.add(LogoutEvent());
            }),
    ];
    return Scaffold(
      drawer: CustomDrawer(
          userName: name.isEmpty ? localizations.name : name,
          itemTitles: items),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          '${localizations.welcome} $name!',
          style: AppStyles.welcomeSytle,
        ),
        actions: [
          if (token.isEmpty)
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.signUp);
                },
                child: Text(localizations.signUp))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 315.w,
              height: 500.h,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset(
                    Assets.slider1,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 50.h,
                    child: Text(
                      localizations.osama,
                      style: AppStyles.redLableStyle.copyWith(fontSize: 44.sp),
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: localizations.distinctvoice,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22.sp,
                    ),
                  ),
                  TextSpan(
                    text: localizations.seemore,
                    style: TextStyle(
                        color: AppColors.accent, fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, Routes.about);
                      },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Link to YouTube
                  SizedBox(height: 20.h),
                  ExpansionTile(
                    title: Text(
                      localizations.socialMedia,
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 22.sp,
                      ),
                    ),
                    trailing: Icon(Icons.expand_more),
                    children: <Widget>[
                      _buildLinkCard(
                          localizations.youtube,
                          localizations.watchLatestEpisodes,
                          'youtube.com@/c/OsamaMounirOfficial'),
                      _buildLinkCard(
                          localizations.socialMedia,
                          localizations.followOsamaOnFacebook,
                          'www.osamamounir.com@/social-media/'),
                      _buildLinkCard(
                          localizations.listeningstations,
                          localizations.listentoepisodes,
                          'www.osamamounir.com@/listening-stations/'),
                    ],
                  ),
                  // Link to Facebook
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildLinkCard(String title, String description, String url) {
  return InkWell(
    onTap: () {
      // Handle the navigation or link opening
      launchURL(url);
    },
    child: Card(
      color: Colors.grey.shade900,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyles.redLableStyle.copyWith(fontSize: 22.sp),
            ),
            SizedBox(height: 10.h),
            Text(
              description,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void launchURL(String url) {
  launchUrl(Uri.https(url.split('@').first, url.split('@').last));
}
