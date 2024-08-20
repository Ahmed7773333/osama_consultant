import 'package:flutter/material.dart';
import 'package:osama_consul/core/api/api_manager.dart';
import 'package:osama_consul/core/api/end_points.dart';
import 'package:osama_consul/core/cache/notification_service.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';
import '../../../../../core/network/firebase_helper.dart';
import '../../../../../core/utils/componetns.dart';
import 'up_load_file.dart';

Future<void> sendMessage(String filePath, TextEditingController controller,
    context, id, bool isAdmin) async {
  try {
    if (_isTextMessage(controller, filePath)) {
      await _sendTextMessage(controller, id, isAdmin);
    } else if (_isAudioMessage(filePath)) {
      await _handleAudioMessage(filePath, id, isAdmin, context);
    }
  } catch (e) {
    Components.showMessage(context,
        content: e.toString(), icon: Icons.error, color: Colors.red);
  }
}

// Check if the message is a text message
bool _isTextMessage(TextEditingController controller, String filePath) {
  return controller.text.trim().isNotEmpty && filePath.isEmpty;
}

// Send a text message
Future<void> _sendTextMessage(
    TextEditingController controller, id, bool isAdmin) async {
  int consultantCount = await _getConsultantCount();
  if (consultantCount == 0 && !isAdmin) {
    throw ('Your Available Consultants is 0, you need to buy first');
  }

  FirebaseHelper().sendMessage(id, controller.text);
  controller.clear();
  await _decreaseConsultantCount(consultantCount);

  await _sendNotification('New Message', id, isAdmin);
}

// Check if the message is an audio message
bool _isAudioMessage(String filePath) {
  return filePath.isNotEmpty;
}

// Handle the audio message sending process
Future<void> _handleAudioMessage(
    String filePath, id, bool isAdmin, BuildContext context) async {
  int consultantCount = await _getConsultantCount();
  if (consultantCount == 0 && !isAdmin) {
    throw ('Your Available Consultants is 0, you need to buy first');
  }

  final audioUrl = await uploadFile(filePath);
  if (audioUrl != null) {
    await FirebaseHelper().sendMessage(id, null, audioUrl: audioUrl);
    await _decreaseConsultantCount(consultantCount);
    await _sendNotification('New Audio Message', id, isAdmin);
  } else {
    _showUploadError(context);
  }
}

// Get the consultant count from user preferences
Future<int> _getConsultantCount() async {
  return await UserPreferences.getConsultantsCount() ?? 0;
}

// Decrease the consultant count and update user preferences
Future<void> _decreaseConsultantCount(int consultantCount) async {
  consultantCount--;
  UserPreferences.setConsultantCount(consultantCount);
  await ApiManager().deleteData(
    EndPoints.consultantMinus,
    data: {'Authorization': 'Bearer ${await UserPreferences.getToken()}'},
  );
}

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
