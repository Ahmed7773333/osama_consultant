import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/utils/app_animations.dart';
import 'package:osama_consul/core/utils/componetns.dart';
import 'package:osama_consul/features/user/Edit%20Profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/pages/home_layout.dart';

import '../../../../../core/cache/shared_prefrence.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/get_itt.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? namee;
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    nameController =
        TextEditingController(text: ((await UserPreferences.getName()) ?? ''));
    phoneController =
        TextEditingController(text: ((await UserPreferences.getPhone()) ?? ''));
    namee = (await UserPreferences.getName()) ?? '';
    setState(() {});
  }

  GlobalKey<FormState> keyy = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => sl<EditProfileBloc>(),
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditLoading) {
            Components.circularProgressHeart(context);
          } else if (state is EditError) {
            Navigator.pop(context);
            Components.showMessage(context,
                content: 'Something went wrong',
                icon: Icons.error,
                color: Colors.red);
          } else if (state is EditSuccess) {
            Navigator.pop(context);
            UserPreferences.updateNameAndPhone(state.name, state.phone);
            setState(() {});
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context, BottomRouting(HomeLayout(page: 3)));
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded)),
            ),
            body: Form(
              key: keyy,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 24.h),
                  Components.customTextField(
                    hint: localizations.fullNameHint,
                    controller: nameController,
                    onChange: (name) {},
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                      onPressed: () {
                        if (keyy.currentState?.validate() ?? false)
                          EditProfileBloc.get(context).add(EditEvent(
                              nameController.text, phoneController.text));
                      },
                      child: Text(localizations.edit))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
