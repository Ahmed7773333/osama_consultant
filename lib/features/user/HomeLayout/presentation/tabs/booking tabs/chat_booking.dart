// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/data/models/chat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatBooking extends StatefulWidget {
  const ChatBooking({super.key});

  @override
  State<ChatBooking> createState() => _ChatBookingState();
}

class _ChatBookingState extends State<ChatBooking> {
  bool hasPaid = false;

  void payWithCoins() {
    // Implement your logic for paying with coins here
    setState(() {
      hasPaid = true;
    });
  }

  void payWithMoney() {
    // Implement your logic for paying with money here
    setState(() {
      hasPaid = true;
    });
  }

  void navigateToChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.pushNamed(context, Routes.chatScreenAdmin, arguments: {
      'id': ChatModel(
          chatName: prefs.getString('name'),
          chatOwner: prefs.getString('email')),
      'isadmin': false
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Booking'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Choose a payment method to consult with a specialist:',
              style: TextStyle(fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: Size(300.w, 60.h)),
              onPressed: payWithCoins,
              child: const Text('Pay with Coins (1 Coin per Consultant)'),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: Size(300.w, 60.h)),
              onPressed: payWithMoney,
              child: const Text('Pay \$30 for One Consultant'),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: hasPaid ? navigateToChat : null,
              child: const Text('Proceed to Chat'),
            ),
          ],
        ),
      ),
    );
  }
}
