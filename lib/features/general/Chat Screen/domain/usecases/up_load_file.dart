import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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
