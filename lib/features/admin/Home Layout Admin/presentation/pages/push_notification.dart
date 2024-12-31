import 'dart:convert'; // For base64 encoding
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/bloc/home_layout_admin_bloc.dart';

class PushNotification extends StatefulWidget {
  const PushNotification(this.bloc, {Key? key}) : super(key: key);
  final HomeLayoutAdminBloc bloc;

  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  final TextEditingController _textController = TextEditingController();
  File? _image;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  String? _encodeImageToBase64(File? imageFile) {
    if (imageFile == null) return null;
    final bytes = imageFile.readAsBytesSync();
    return base64Encode(bytes);
  }

  void _sendPushNotification() {
    final text = _textController.text.trim();
    final encodedImage = _encodeImageToBase64(_image);

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Text cannot be empty')),
      );
      return;
    }

    if (encodedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    // Add the event to the bloc
    widget.bloc.add(AddQuoteEvent(text, encodedImage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Push Notification')),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.h),
            _image != null
                ? Image.file(_image!, height: 200.h)
                : Container(
                    height: 200.h,
                    color: Colors.grey[300],
                    child: Center(child: Text('No image selected')),
                  ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _sendPushNotification,
              child: Text('Push'),
            ),
          ],
        ),
      ),
    );
  }
}
