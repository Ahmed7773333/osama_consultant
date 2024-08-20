// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// Future<File?> _pickImage(ImageSource source) async {
//   final pickedFile = await ImagePicker().pickImage(source: source);
//   if (pickedFile != null) {
//     return File(pickedFile.path);
//   }
//   return null;
// }

// showBottommSheeet(context) {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) => BottomSheet(
//       onClosing: () {},
//       builder: (context) => Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: const Icon(Icons.camera),
//             title: const Text('Camera'),
//             onTap: () {
//               Navigator.pop(context);
//               _pickImage(ImageSource.camera);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.photo_library),
//             title: const Text('Gallery'),
//             onTap: () {
//               Navigator.pop(context);
//               _pickImage(ImageSource.gallery);
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }
