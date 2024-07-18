// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osama_consul/core/network/firebase_helper.dart';

class ChatModel {
  final String? chatOwner;
  final String? chatName;
  ChatModel({
    this.chatOwner,
    this.chatName,
  });
  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    return ChatModel(
      chatOwner: doc[FirebaseHelper.chatOwner],
      chatName: doc[FirebaseHelper.chatName],
    );
  }
  static Future<List<Message>> fetchMessages(String chatId) async {
    QuerySnapshot messageSnapshot = await FirebaseFirestore.instance
        .collection(FirebaseHelper.chatCollection)
        .doc(chatId)
        .collection(FirebaseHelper.messagesCollection)
        .orderBy(FirebaseHelper.time, descending: true)
        .get();

    return messageSnapshot.docs
        .map((doc) => Message.fromDocument(doc))
        .toList();
  }
}

class Message {
  final String? text;
  final String senderId;
  final Timestamp timestamp;
  final String? audioUrl;

  Message({
    this.text,
    required this.senderId,
    required this.timestamp,
    this.audioUrl,
  });

  factory Message.fromDocument(DocumentSnapshot doc) {
    return Message(
      text: doc[FirebaseHelper.text],
      senderId: doc[FirebaseHelper.senderId],
      timestamp: doc[FirebaseHelper.time],
      audioUrl: doc[FirebaseHelper.audioUrl],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      FirebaseHelper.text: text,
      FirebaseHelper.senderId: senderId,
      FirebaseHelper.time: timestamp,
      FirebaseHelper.audioUrl: audioUrl,
    };
  }
}
