import 'package:flutter/material.dart';
import 'package:osama_consul/core/cache/notification_service.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';
import '../../../../../core/network/firebase_helper.dart';
import 'up_load_file.dart';

Future<void> sendMessage(String filePath, TextEditingController controller,
    context, id, bool isAdmin) async {
  if (_isTextMessage(controller, filePath)) {
    await _sendTextMessage(controller, id, isAdmin);
  } else if (_isAudioMessage(filePath)) {
    await _handleAudioMessage(filePath, id, isAdmin, context);
  }
}

// Check if the message is a text message
bool _isTextMessage(TextEditingController controller, String filePath) {
  return controller.text.trim().isNotEmpty && filePath.isEmpty;
}

// Send a text message
Future<void> _sendTextMessage(
    TextEditingController controller, id, bool isAdmin) async {
  bool isOpend = await FirebaseHelper().getIsOpened(id);
  if (!isOpend && !isAdmin) {
    throw ('You have to use a Consultant first');
  }

  FirebaseHelper().sendMessage(id, controller.text);
  controller.clear();

  await _sendNotification('New Message', id, isAdmin);
}

// Check if the message is an audio message
bool _isAudioMessage(String filePath) {
  return filePath.isNotEmpty;
}

// Handle the audio message sending process
Future<void> _handleAudioMessage(
    String filePath, id, bool isAdmin, BuildContext context) async {
  bool isOpend = await FirebaseHelper().getIsOpened(id);
  if (!isOpend && !isAdmin) {
    throw ('You have to use a Consultant first');
  }

  final audioUrl = await uploadFile(filePath);
  if (audioUrl != null) {
    await FirebaseHelper().sendMessage(id, null, audioUrl: audioUrl);

    await _sendNotification('New Audio Message', id, isAdmin);
  } else {
    _showUploadError(context);
  }
}

// Get the consultant count from user preferences

// Send a push notification
Future<void> _sendNotification(String title, id, bool isAdmin) async {
  final name = await UserPreferences.getName();
  final recipient = isAdmin ? id : 'admin@chat.com';
  NotificationService().pushNotification(title, 'From $name', recipient);
}

// Show an error message if audio file upload fails
void _showUploadError(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Error uploading audio file')),
  );
}
