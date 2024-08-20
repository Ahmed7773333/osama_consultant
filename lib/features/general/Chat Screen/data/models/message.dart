import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/network/firebase_helper.dart';

class MessageModel {
  final String? text;
  final String senderId;
  final Timestamp timestamp;
  final String? audioUrl;
  final bool isRead;

  MessageModel({
    this.text,
    required this.senderId,
    required this.timestamp,
    this.audioUrl,
    required this.isRead,
  });

  factory MessageModel.fromDocument(DocumentSnapshot doc) {
    return MessageModel(
      text: doc[FirebaseHelper.text],
      senderId: doc[FirebaseHelper.senderId],
      timestamp: doc[FirebaseHelper.time],
      audioUrl: doc[FirebaseHelper.audioUrl],
      isRead: doc[FirebaseHelper.isRead],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      FirebaseHelper.text: text,
      FirebaseHelper.senderId: senderId,
      FirebaseHelper.time: timestamp,
      FirebaseHelper.audioUrl: audioUrl,
      FirebaseHelper.isRead: isRead
    };
  }
}
