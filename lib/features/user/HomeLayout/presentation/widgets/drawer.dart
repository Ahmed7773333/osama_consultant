import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/bloc/homelayout_bloc.dart';

import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../general/settings/presentation/bloc/settings_bloc.dart';
import 'charge.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  final List<DrawerItem> itemTitles;
  final String token;
  final HomelayoutBloc? bloc;
  CustomDrawer(this.token,
      {required this.userName, required this.itemTitles, this.bloc});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...itemTitles
                .map((item) => DrawerItem(
                      title: item.title,
                      icon: item.icon,
                      onTap: item.onTap,
                    ))
                .toList(),
            if (token.isNotEmpty && bloc != null) ChargeWalletMenu(),
            if (token.isNotEmpty && bloc != null)
              DrawerItem(
                  title: localizations.signOut,
                  icon: Icons.logout,
                  onTap: () {
                    bloc!.add(LogoutEvent());
                  }),
            Spacer(), // Pushes the dropdown to the bottom of the drawer
            Padding(
              padding: EdgeInsets.all(16.r),
              child: LanguageDropdown(),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;

  const DrawerItem({
    required this.title,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(title),
      onTap: onTap ?? () {}, // Default to a no-op if no action provided
    );
  }
}

class LanguageDropdown extends StatefulWidget {
  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String selectedLanguage = 'English';
  // Default language
  @override
  void initState() {
    setSelectedLanguage();
    super.initState();
  }

  setSelectedLanguage() async {
    selectedLanguage =
        (await UserPreferences.getIsEnglish())! ? 'English' : 'عربي';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return Row(
        children: [
          Icon(Icons.language, color: Colors.grey),
          SizedBox(width: 8.w),
          DropdownButton<String>(
            value: selectedLanguage,
            items: [
              DropdownMenuItem(
                value: 'English',
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: 'عربي',
                child: Text('عربي'),
              ),
            ],
            onChanged: (String? newValue) {
              setState(() {
                if (selectedLanguage != newValue!) {
                  selectedLanguage = newValue;
                  context.read<SettingsBloc>().add(SwitchLanguage());
                }
              });
            },
          ),
        ],
      );
    });
  }
}
