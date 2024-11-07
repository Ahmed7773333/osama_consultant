// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../../core/utils/app_colors.dart';

class MessageBubble extends StatefulWidget {
  final String text;
  final bool isMe;
  final String? audioUrl;
  final bool isfile;

  const MessageBubble(this.text, this.isMe,
      {this.audioUrl, this.isfile = false, super.key});

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 0.75 * MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            color: widget.isMe
                ? (widget.audioUrl == null
                    ? Colors.grey[300]
                    : AppColors.secondry)
                : AppColors.secondry,
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
          margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.audioUrl == null)
                Text(
                  widget.text,
                  style: TextStyle(
                      color: widget.isMe ? Colors.black : Colors.white),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                )
              else
                VoiceMessageView(
                  controller: VoiceController(
                    audioSrc: widget.audioUrl!,
                    onComplete: () {},
                    onPause: () {},
                    onPlaying: () {},
                    onError: (err) {},
                    maxDuration: const Duration(minutes: 10),
                    isFile: widget.isfile,
                  ),
                  innerPadding: 12.r,
                  cornerRadius: 20.r,
                  activeSliderColor: Colors.red,
                  backgroundColor: AppColors.secondry,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
