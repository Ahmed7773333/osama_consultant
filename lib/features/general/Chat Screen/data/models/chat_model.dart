// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osama_consul/core/network/firebase_helper.dart';
import 'package:osama_consul/features/general/Chat%20Screen/data/models/message.dart';

class ChatModel {
  final String? chatOwner;
  final String? chatName;
  final int? unReadCount;
  ChatModel({
    this.chatOwner,
    this.chatName,
    this.unReadCount,
  });
  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    return ChatModel(
      chatOwner: doc[FirebaseHelper.chatOwner],
      chatName: doc[FirebaseHelper.chatName],
      unReadCount: doc[FirebaseHelper.chatCountUnRead],
    );
  }
  static Future<List<MessageModel>> fetchMessages(String chatId) async {
    QuerySnapshot messageSnapshot = await FirebaseFirestore.instance
        .collection(FirebaseHelper.chatCollection)
        .doc(chatId)
        .collection(FirebaseHelper.messagesCollection)
        .orderBy(FirebaseHelper.time, descending: true)
        .get();

    return messageSnapshot.docs
        .map((doc) => MessageModel.fromDocument(doc))
        .toList();
  }
}
