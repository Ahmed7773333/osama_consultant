import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/api/api_manager.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../../core/utils/componetns.dart';

class GenerateCode extends StatefulWidget {
  @override
  _GenerateCodeState createState() => _GenerateCodeState();
}

class _GenerateCodeState extends State<GenerateCode> {
  final TextEditingController _controller = TextEditingController();

  /// Function to generate a random voucher code
  String generateVoucherCode() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const codeLength = 8; // Length of the voucher code
    final random = Random();

    return String.fromCharCodes(
      Iterable.generate(
        codeLength,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generate Code')),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _controller.text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Text copied to clipboard')),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Generate a new voucher code and display it in the text field
                    setState(() {
                      _controller.text = generateVoucherCode();
                    });
                  },
                  child: Text('Generate'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Deploy the generated code using an API call
                    await ApiManager().postDataa(
                      EndPoints.enterCode,
                      body: {'code': _controller.text},
                      data: {
                        'Authorization':
                            'Bearer ${await UserPreferences.getToken()}'
                      },
                    ).then((r) async {
                      if (r.statusCode == 201) {
                        Components.showMessage(context,
                            content: 'Done',
                            icon: Icons.check,
                            color: Colors.green);
                      } else {
                        Components.showMessage(context,
                            content: 'Error',
                            icon: Icons.error,
                            color: Colors.red);
                      }
                    });
                  },
                  child: Text('Deploy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
