import 'package:flutter/material.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/cache/shared_prefrence.dart';

Widget drrawer(context, name, phone) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(name),
          accountEmail: Text(phone),
          currentAccountPicture: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('My Doctors'),
          onTap: () {
            // Handle navigation
          },
        ),
        ListTile(
          leading: const Icon(Icons.description),
          title: const Text('Medical Records'),
          onTap: () {
            // Handle navigation
          },
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
          leading: const Icon(Icons.local_pharmacy),
          title: const Text('Medicine Orders'),
          onTap: () {
            // Handle navigation
          },
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today),
          title: const Text('Test Bookings'),
          onTap: () {
            // Handle navigation
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
            await removeUserData();
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.signUp,
              (Route<dynamic> route) => false,
            );
          },
        ),
      ],
    ),
  );
}
