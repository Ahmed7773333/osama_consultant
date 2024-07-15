import 'package:flutter/material.dart';

import '../../../../core/network/firebase_helper.dart';
import 'up_load_file.dart';

Future<void> sendMessage(
    String filePath, TextEditingController controller, context, id) async {
  if (controller.text.trim().isNotEmpty && filePath.isEmpty) {
    FirebaseHelper().sendMessage(id, controller.text);
    controller.clear();
  } else {
    try {
      if (filePath.isNotEmpty) {
        final audioUrl = await uploadFile(filePath);
        if (audioUrl != null) {
          FirebaseHelper().sendMessage(id, null, audioUrl: audioUrl);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error uploading audio file')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
