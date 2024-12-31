import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/bloc/homelayout_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../../core/network/check_internet.dart';

class Quote extends StatefulWidget {
  const Quote(this.bloc, {super.key});
  final HomelayoutBloc bloc;
  @override
  State<Quote> createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  String? base64Image; // الصورة بصيغة base64
  String? quote;
  // النص (المقولة)
  bool? isSub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setIsSub();
  }

  setIsSub() async {
    isSub = (await UserPreferences.getIsSub());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Center(
          child: !(isSub ?? false)
              ? _buildSubscriptionContainer()
              : ListView.builder(
                  itemCount: widget.bloc.quotes.length,
                  itemBuilder: (context, index) {
                    final quote = widget.bloc.quotes[index];
                    final base64Image =
                        quote.image; // Assuming each quote has an image

                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      elevation: 4,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r),
                            ),
                            child: _buildImage(base64Image ?? ''),
                          ),
                          ListTile(
                            title: Text(
                              quote.quote ?? '',
                              style: TextStyle(fontSize: 20.sp),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  // Widget لعرض صورة من base64
  Widget _buildImage(String base64Image) {
    if (base64Image.length > 100) {
      try {
        final decodedBytes = base64Decode(base64Image);
        return Container(
          height: 400.h, // Adjust height as needed
          width: double.infinity, // Take full width
          child: Image.memory(
            decodedBytes,
            fit: BoxFit.fill, // Ensure the image fits within the container
          ),
        );
      } catch (e) {
        // Handle any decoding errors
        return Text('Invalid image data', style: TextStyle(color: Colors.red));
      }
    }
    return Text('');
  }

  // Widget لعرض Container الاشتراك
  Widget _buildSubscriptionContainer() {
    final localizations = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () async {
        bool isConnect = await ConnectivityService().getConnectionStatus();
        if (isConnect)
          Navigator.pushNamed(context, Routes.paymentMethods,
              arguments: {'is_ticket': false});
      },
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          border: Border.all(color: Colors.blue, width: 2.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock, size: 50.r, color: Colors.blue),
            SizedBox(height: 16.h),
            Text(
              localizations.subscribe,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
