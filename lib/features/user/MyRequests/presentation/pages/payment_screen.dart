import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/cubit/myrequests_cubit.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  void handlePayment() {
    // Handle payment process
  }

  Widget buildSlotCard() {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: 1', style: TextStyle(fontSize: 16.sp)),
            Text('Schedule ID: 1001', style: TextStyle(fontSize: 16.sp)),
            Text('From: 09:00 AM', style: TextStyle(fontSize: 16.sp)),
            Text('To: 10:00 AM', style: TextStyle(fontSize: 16.sp)),
            Text('Status: Confirmed', style: TextStyle(fontSize: 16.sp)),
            Text('Created At: 2024-07-22 10:00:00',
                style: TextStyle(fontSize: 16.sp)),
            Text('Updated At: 2024-07-22 10:30:00',
                style: TextStyle(fontSize: 16.sp)),
            Text('Schedule: Monday', style: TextStyle(fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyrequestsCubit(),
      child: BlocConsumer<MyrequestsCubit, MyrequestsState>(
        listener: (context, state) {
          if (state is SuccessRequestTokenCardPaymentState) {
            Navigator.pushNamed(context, Routes.visaScreen,
                arguments: {'cubit': MyrequestsCubit.get(context)});
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Payment Screen'),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.r),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildSlotCard(),
                    SizedBox(height: 20.h),
                    const Text(
                      'The fee will be 30\$',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {
                        MyrequestsCubit.get(context).getAuthToken();
                      },
                      child: Text(
                        'Pay',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
