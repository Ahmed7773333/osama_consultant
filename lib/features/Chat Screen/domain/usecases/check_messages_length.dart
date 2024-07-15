import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/network/firebase_helper.dart';

void checkMessageLength(int i, id, action) {
  FirebaseFirestore.instance
      .collection(FirebaseHelper.chatCollection)
      .doc(id)
      .collection(FirebaseHelper.messagesCollection)
      .orderBy(FirebaseHelper.time, descending: false)
      .snapshots()
      .listen((snapshot) {
    if (i < snapshot.docs.length) {
      action();
    }
  });
}
