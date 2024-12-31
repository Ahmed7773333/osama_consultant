import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';

import '../../features/general/Chat Screen/data/models/message.dart';

class FirebaseHelper {
  static String chatCollection = 'chats';
  static String messagesCollection = 'messages';
  static String signIn = 'signIn_message';
  static String audioUrl = 'audioUrl';
  static String senderId = 'senderId';
  static String text = 'text';
  static String time = 'time';
  static String isRead = 'isRead';
  static String chatOwner = 'chatOwner';
  static String chatName = 'chatName';
  static String chatCountUnRead = 'UnRead Counter';
  static String isOpened = 'IsOpened';

  Future<void> makeCustomerChat(userModel) async {
    if ((userModel.data!.isAdmin!) == 0) {
      // Get a reference to the document with the chatId
      DocumentReference docRef = FirebaseFirestore.instance
          .collection(chatCollection)
          .doc(userModel.data!.email!);

      // Check if the document already exists
      DocumentSnapshot doc = await docRef.get();
      if (!doc.exists) {
        // Document does not exist, so add it
        await docRef.set({
          chatOwner: userModel.data!.email!,
          chatName: userModel.data!.name!,
          chatCountUnRead: 0,
          isOpened: false
        });
      }
    }
  }

  Future<String?> uploadFile(String filePath) async {
    File file = File(filePath);

    try {
      final ref =
          FirebaseStorage.instance.ref('uploads/${filePath.split('/').last}');
      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();
      debugPrint('File uploaded successfully');
      return downloadUrl;
    } on FirebaseException catch (e) {
      debugPrint('Upload failed: $e');
      return null;
    }
  }

  Future<void> sendMessage(String id, String? text, {String? audioUrl}) async {
    try {
      final senderId = (await UserPreferences.getEmail())!;
      final isAdmin = ((await UserPreferences.getIsAdmin())!) == 1;

      final message = MessageModel(
        text: text,
        senderId: senderId,
        timestamp: Timestamp.now(),
        audioUrl: audioUrl,
        isRead: isAdmin,
      );

      final chatDocRef = FirebaseFirestore.instance
          .collection(FirebaseHelper.chatCollection)
          .doc(id);
      final messageCollectionRef =
          chatDocRef.collection(FirebaseHelper.messagesCollection);
      messageCollectionRef.doc().set(message.toMap());
      if (!isAdmin)
        await chatDocRef
            .update({FirebaseHelper.chatCountUnRead: FieldValue.increment(1)});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> markAllMessagesAsReadAndResetUnreadCount(String id) async {
    final isAdmin = (await UserPreferences.getIsAdmin()) == 1;
    if (isAdmin) {
      final chatDocRef = FirebaseFirestore.instance
          .collection(FirebaseHelper.chatCollection)
          .doc(id);
      final messageCollectionRef =
          chatDocRef.collection(FirebaseHelper.messagesCollection);
      await chatDocRef.update({FirebaseHelper.chatCountUnRead: 0});
      final messagesQuery = await messageCollectionRef.get();
      for (var doc in messagesQuery.docs) {
        doc.reference.update({FirebaseHelper.isRead: true});
      }
    } else
      return null;
  }

  Future<bool> getIsOpened(String chatId) async {
    try {
      bool n = false;
      DocumentReference doc = await FirebaseFirestore.instance
          .collection(chatCollection)
          .doc(chatId);

      await doc.get().then((s) {
        debugPrint('here');
        n = s.get(isOpened);
        debugPrint(n.toString());
      });
      return n;
    } catch (e) {
      debugPrint("Error retrieving isOpened: $e");
      return false;
    }
  }
}
