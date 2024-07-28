import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/bloc/homelayout_bloc.dart';

import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../widgets/drawer.dart';
import '../widgets/profile_textfield.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab(this.bloc, {super.key});
  final HomelayoutBloc bloc;
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  Uint8List? _imageBytes;
  String namee = '';
  String emaill = '';
  String phonee = '';

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: '');
    email = TextEditingController(text: '');
    phone = TextEditingController(text: '');
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    namee = (await UserPreferences.getName()) ?? '';
    emaill = (await UserPreferences.getEmail()) ?? '';
    phonee = (await UserPreferences.getPhone()) ?? '';
    setState(() {
      name = TextEditingController(text: namee);
      email = TextEditingController(text: emaill);
      phone = TextEditingController(text: phonee);
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.h),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.r),
              ),
              child: AppBar(
                backgroundColor: AppColors.secondry,
                title: Text(
                  'Profile',
                  style: AppStyles.titleStyle,
                ),
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 100
                  .h, // Adjust this value to place the avatar at the desired height
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Colors.grey[200],
                  backgroundImage:
                      _imageBytes != null ? MemoryImage(_imageBytes!) : null,
                  child: _imageBytes == null
                      ? IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => BottomSheet(
                                onClosing: () {},
                                builder: (context) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.camera),
                                      title: const Text('Camera'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _pickImage(ImageSource.camera);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text('Gallery'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _pickImage(ImageSource.gallery);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.camera),
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: drrawer(context, namee, phonee, widget.bloc),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            customTextField(context,
                controller: name, icon: Icons.person, hint: 'Name'),
            SizedBox(height: 50.h),
            customTextField(context,
                controller: phone, icon: Icons.phone, hint: 'Phone Number'),
            SizedBox(height: 50.h),
            customTextField(context,
                controller: email, icon: Icons.email, hint: 'Email'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }
}
