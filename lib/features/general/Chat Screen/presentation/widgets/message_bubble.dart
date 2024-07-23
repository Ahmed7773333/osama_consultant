// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';

class MessageBubble extends StatefulWidget {
  final String text;
  final bool isMe;
  final String? audioUrl;

  const MessageBubble(this.text, this.isMe, {this.audioUrl, super.key});

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    widget.audioUrl != null ? _audioPlayer.setUrl(widget.audioUrl!) : null;
    // Listen for the completion event
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
    // Listen for the playback events
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _duration = duration ?? Duration.zero;
      });
    });

    // Listen for the completion event
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
          _position = Duration.zero;
        });
      }
    });
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _isPlaying = false;
      setState(() {});

      _audioPlayer.pause();
    } else {
      _isPlaying = true;
      setState(() {});
      _audioPlayer.play();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.isMe ? Colors.grey[300] : Colors.blue[300],
            borderRadius: BorderRadius.circular(12.r),
          ),
          width:
              widget.audioUrl == null ? 150.w : 300.w, // Adjust width as needed
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
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Slider(
                      value: _position.inSeconds.toDouble(),
                      min: 0.0,
                      max: _duration.inSeconds.toDouble(),
                      onChanged: (double value) {
                        _audioPlayer.seek(Duration(seconds: value.toInt()));
                      },
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey[300],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: widget.isMe ? Colors.black : Colors.white,
                          ),
                          onPressed: _togglePlayPause,
                        ),
                        Text(
                          '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')} / '
                          '${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: widget.isMe ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
