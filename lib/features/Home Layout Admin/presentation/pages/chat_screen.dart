// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/features/Home%20Layout%20Admin/data/models/chat_model.dart';
import 'package:osama_consul/features/Home%20Layout%20Admin/presentation/widgets/message_bubble.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/network/firebase_helper.dart';
import '../bloc/home_layout_admin_bloc.dart';

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

class ChatScreen extends StatefulWidget {
  const ChatScreen(this.id, this.fromAdmin, {super.key});
  final ChatModel id;
  final bool fromAdmin;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  String _filePath = '';
  bool _isRecording = false;
  bool _isPaused = false;
  bool _isPlaying = false;
  late AudioPlayer _audioPlayer;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initRecorder();
    _initPlayer();

    _audioPlayer = AudioPlayer();

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

  Future<void> _initRecorder() async {
    await _requestMicrophonePermission();
    await _recorder.openRecorder();
  }

  Future<void> _initPlayer() async {
    await _player.openPlayer();
  }

  Future<void> _requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
  }

  Future<void> _startRecording() async {
    final dir = await getApplicationDocumentsDirectory();

    setState(() {
      _isRecording = true;
      _filePath =
          '${dir.path}/audio_message_${DateTime.now().millisecondsSinceEpoch}.aac';
    });
    await _recorder.startRecorder(toFile: _filePath);
  }

  Future<void> _pauseRecording() async {
    setState(() {
      _isPaused = true;
    });
    await _recorder.pauseRecorder();
  }

  Future<void> _resumeRecording() async {
    setState(() {
      _isPaused = false;
    });
    await _recorder.resumeRecorder();
  }

  Future<void> _stopRecording() async {
    setState(() {
      _isRecording = false;
    });
    await _recorder.stopRecorder();
  }

  Future<String> stopRecording() async {
    await _recorder.stopRecorder();
    return _filePath;
  }

  void _seekTo(double position) async {
    setState(() {
      _position = Duration(milliseconds: position.toInt());
    });
    await _audioPlayer.seek(Duration(milliseconds: position.toInt()));
  }

  @override
  void dispose() {
    _controller.dispose();
    _recorder.closeRecorder();
    _player.closePlayer();
    _audioPlayer.dispose();

    super.dispose();
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      _isPlaying = false;
      setState(() {});

      await _audioPlayer.pause();
    } else {
      _isPlaying = true;
      setState(() {});

      await _audioPlayer.setFilePath(_filePath);

      await _audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutAdminBloc()
        ..add(GetChatMessagesEvent(widget.id.chatOwner ?? '')),
      child: BlocConsumer<HomeLayoutAdminBloc, HomeLayoutAdminState>(
        listener: (BuildContext context, HomeLayoutAdminState state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () async {
                  await HomeLayoutAdminBloc.get(context).close();
                  if (widget.fromAdmin) {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.homeLayoutAdmin,
                      arguments: {'page': 1},
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20.r,
                ),
              ),
              title: Text(widget.id.chatName ?? ""),
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    maxLines: 10,
                    maxLength: 1000,
                    decoration: const InputDecoration(
                      labelText: 'Send a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    _isRecording
                        ? IconButton(
                            icon: !_isPaused
                                ? const Icon(Icons.play_arrow)
                                : const Icon(Icons.pause),
                            onPressed:
                                _isPaused ? _resumeRecording : _pauseRecording,
                          )
                        : IconButton(
                            icon: const Icon(Icons.mic),
                            onPressed: _startRecording,
                          ),
                    if (_isRecording)
                      IconButton(
                        icon: const Icon(Icons.stop),
                        onPressed: _stopRecording,
                      ),
                    if (!_isRecording && _filePath.isNotEmpty)
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                        onPressed: _togglePlayPause,
                      ),
                    Expanded(
                      child: Container(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        if (_controller.text.trim().isNotEmpty &&
                            _filePath.isEmpty) {
                          FirebaseHelper().sendMessage(
                              widget.id.chatOwner, _controller.text);
                          _controller.clear();
                        } else {
                          try {
                            final audioUrl = await uploadFile(_filePath);
                            if (audioUrl != null) {
                              FirebaseHelper().sendMessage(
                                  widget.id.chatOwner, null,
                                  audioUrl: audioUrl);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Error uploading audio file')),
                              );
                            }
                          } catch (e) {
                            // Handle any errors that occur during recording or uploading
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${e.toString()}')),
                            );
                          }
                        }
                        HomeLayoutAdminBloc.get(context).add(
                            GetChatMessagesEvent(widget.id.chatOwner ?? ''));
                      },
                    ),
                  ],
                ),
                if (_filePath.isNotEmpty && !_isRecording)
                  Slider(
                    value: _position.inMilliseconds.toDouble(),
                    min: 0.0,
                    max: _duration.inMilliseconds.toDouble() * 1.01,
                    onChanged: (value) {
                      _seekTo(value);
                    },
                  ),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: HomeLayoutAdminBloc.get(context).messages.length,
                    itemBuilder: (ctx, index) {
                      final isMe = (widget.id.chatOwner ?? '') ==
                          (HomeLayoutAdminBloc.get(context)
                              .messages[index]
                              .senderId);
                      return MessageBubble(
                        HomeLayoutAdminBloc.get(context).messages[index].text ??
                            '',
                        isMe,
                        audioUrl: HomeLayoutAdminBloc.get(context)
                            .messages[index]
                            .audioUrl,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
