import 'package:flutter/material.dart';
import 'package:osama_consul/core/cache/notification_service.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';

import '../../../../../core/network/firebase_helper.dart';
import 'up_load_file.dart';

Future<void> sendMessage(String filePath, TextEditingController controller,
    context, id, bool isAdmin) async {
  if (controller.text.trim().isNotEmpty && filePath.isEmpty) {
    FirebaseHelper().sendMessage(id, controller.text);

    controller.clear();
    if (isAdmin) {
      NotificationService().pushNotification(
          'New Message', 'From${await UserPreferences.getName()}', id);
    } else {
      NotificationService().pushNotification('New Message',
          'From${await UserPreferences.getName()}', 'admin@chat.com');
    }
  } else {
    try {
      if (filePath.isNotEmpty) {
        final audioUrl = await uploadFile(filePath);
        if (audioUrl != null) {
          FirebaseHelper().sendMessage(id, null, audioUrl: audioUrl);
          if (isAdmin) {
            NotificationService().pushNotification('New Audio Message',
                'From${await UserPreferences.getName()}', id);
          } else {
            NotificationService().pushNotification('New Audio Message',
                'From${await UserPreferences.getName()}', 'admin@chat.com');
          }
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
