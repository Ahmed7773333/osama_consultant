import 'package:flutter/material.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/bloc/homelayout_bloc.dart';

import '../../../../../config/app_routes.dart';

Widget drrawer(context, name, phone, HomelayoutBloc bloc) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(color: Colors.green),
          accountName: Text(name),
          accountEmail: Text(phone),
          currentAccountPicture: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('My Requests'),
          onTap: () {
            // Handle navigation
            Navigator.pushNamed(context, Routes.myRequests);
          },
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Privacy & Policy'),
          onTap: () {
            // Handle navigation
          },
        ),
        ListTile(
          leading: const Icon(Icons.help_center),
          title: const Text('Help Center'),
          onTap: () {
            // Handle navigation
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Navigator.pushNamed(context, Routes.settings);
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () async {
            bloc.add(LogoutEvent());
          },
        ),
      ],
    ),
  );
}
