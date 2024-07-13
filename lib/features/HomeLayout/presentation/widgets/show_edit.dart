import 'package:flutter/material.dart';

import '../../../../core/utils/componetns.dart';

void showEditProfileDialog(
    {required BuildContext context,
    required TextEditingController controller,
    hint}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit $hint'),
        content: Components.customTextField(
            hint: hint,
            controller: controller,
            isPhone: hint == 'Phone Number'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              // Handle save action
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
