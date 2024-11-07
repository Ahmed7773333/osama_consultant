import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/app_styles.dart';
import 'package:osama_consul/features/general/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../../core/network/check_internet.dart';
import '../bloc/homelayout_bloc.dart';
import '../widgets/profile_widgets.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab(this.bloc, {super.key});
  final HomelayoutBloc bloc;
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String namee = '';
  String emaill = '';
  String phonee = '';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    namee = (await UserPreferences.getName()) ?? '';
    emaill = (await UserPreferences.getEmail()) ?? '';
    phonee = (await UserPreferences.getPhone()) ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.all(10.r),
        child: ListView(
          children: [
            // User card
            BigUserCard(
              backgroundColor: Colors.red,
              userName: namee,
              userProfilePic: Center(
                  child: Text(namee.isNotEmpty ? namee[0] : '',
                      style: AppStyles.welcomeSytle
                          .copyWith(color: Colors.white, fontSize: 50.sp))),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  withBackground: true,
                  borderRadius: 50.r,
                  backgroundColor: Colors.yellow[600],
                ),
                title: localizations.modify,
                subtitle: localizations.tapToChangeData,
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.editProfile);
                },
              ),
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.myRequests);
                  },
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title: localizations.myRequests,
                  subtitle: localizations.seeYourRequestsStatus,
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.language_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: localizations.language,
                  subtitle: localizations.automatic,
                  trailing: Switch.adaptive(
                    value: context.read<SettingsBloc>().isEnglish,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(SwitchLanguage());
                    },
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.about);
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: localizations.about,
                  subtitle: localizations.learnMoreAboutApp,
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: localizations.account,
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.notifications,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.blue,
                  ),
                  title: localizations.notifications,
                  trailing: Switch.adaptive(
                    value: context.read<SettingsBloc>().isNotificationsEnabled,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(ToggleNotification());
                    },
                  ),
                ),
                SettingsItem(
                  onTap: () async {
                    bool isConnect =
                        await ConnectivityService().getConnectionStatus();
                    if (isConnect) widget.bloc.add(LogoutEvent());
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: localizations.signOut,
                  titleStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
