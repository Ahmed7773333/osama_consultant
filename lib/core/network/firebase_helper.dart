import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/user/HomeLayout/data/models/message.dart';

class FirebaseHelper {
  static String chatCollection = 'chats';
  static String messagesCollection = 'messages';
  static String signIn = 'signIn_message';
  static String audioUrl = 'audioUrl';
  static String senderId = 'senderId';
  static String text = 'text';
  static String time = 'time';
  static String chatOwner = 'chatOwner';
  static String chatName = 'chatName';

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
          chatName: userModel.data!.name!
        });
        // FirebaseFirestore.instance
        //     .collection(chatCollection)
        //     .doc(userModel.data!.email!)
        //     .collection(messagesCollection)
        //     .add(MessageModel(
        //             senderId: userModel.data!.email!,
        //             timestamp: Timestamp.now(),
        //             text: null,
        //             audioUrl: null)
        //         .toMap());
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

  Future<void> sendMessage(id, text, {String? audioUrl}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      final message = MessageModel(
        text: text,
        senderId: pref.getString('email')!,
        timestamp: Timestamp.now(),
        audioUrl: audioUrl,
      );
      FirebaseFirestore.instance
          .collection(chatCollection)
          .doc(id)
          .collection(messagesCollection)
          .add(message.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
