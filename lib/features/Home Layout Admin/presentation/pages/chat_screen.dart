// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/features/Home%20Layout%20Admin/data/models/chat_model.dart';
import 'package:osama_consul/features/Home%20Layout%20Admin/presentation/widgets/message_bubble.dart';

import '../../../../core/network/firebase_helper.dart';
import '../../domain/usecases/up_load_file.dart';
import '../bloc/home_layout_admin_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(this.id, this.fromAdmin, {super.key});
  final ChatModel id;
  final bool fromAdmin;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutAdminBloc()
        ..add(GetChatMessagesEvent(widget.id.chatOwner ?? ''))
        ..add(InitRecorder())
        ..add(ListenToPlayer()),
      child: BlocConsumer<HomeLayoutAdminBloc, HomeLayoutAdminState>(
        listener: (BuildContext context, HomeLayoutAdminState state) {},
        builder: (context, state) {
          final bloc = HomeLayoutAdminBloc.get(context);
          // bloc.add(GetChatMessagesEvent(widget.id.chatOwner ?? ''));
          // bloc.add(ListenToPlayer());

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () async {
                  bloc.add(CloseEvent());
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
                    bloc.isRecording
                        ? IconButton(
                            icon: bloc.isPaused
                                ? const Icon(Icons.play_arrow)
                                : const Icon(Icons.pause),
                            onPressed: bloc.isPaused
                                ? () => bloc.add(ResumeRecorder())
                                : () => bloc.add(PauseRecorder()),
                          )
                        : IconButton(
                            icon: const Icon(Icons.mic),
                            onPressed: () => bloc.add(StartRecorder()),
                          ),
                    if (bloc.isRecording)
                      IconButton(
                        icon: const Icon(Icons.stop),
                        onPressed: () => bloc.add(StopRecorder()),
                      ),
                    if (!bloc.isRecording && bloc.filePath.isNotEmpty)
                      IconButton(
                        icon: Icon(
                            bloc.isPlaying ? Icons.stop : Icons.play_arrow),
                        onPressed: () => bloc.add(TogglePlayPause()),
                      ),
                    Expanded(
                      child: Container(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        if (_controller.text.trim().isNotEmpty &&
                            bloc.filePath.isEmpty) {
                          FirebaseHelper().sendMessage(
                              widget.id.chatOwner, _controller.text);
                          _controller.clear();
                        } else {
                          try {
                            final audioUrl = await uploadFile(bloc.filePath);
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${e.toString()}')),
                            );
                          }
                        }
                        bloc.add(
                            GetChatMessagesEvent(widget.id.chatOwner ?? ''));
                      },
                    ),
                  ],
                ),
                if (bloc.filePath.isNotEmpty && !bloc.isRecording)
                  BlocBuilder<HomeLayoutAdminBloc, HomeLayoutAdminState>(
                    builder: (context, state) {
                      return Slider(
                        value: bloc.position.inMilliseconds.toDouble(),
                        min: 0.0,
                        max: bloc.duration.inMilliseconds.toDouble() * 1.01,
                        onChanged: (value) {
                          bloc.add(SeekTo(value));
                        },
                      );
                    },
                  ),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: bloc.messages.length,
                    itemBuilder: (ctx, index) {
                      final isMe = (widget.id.chatOwner ?? '') ==
                          (bloc.messages[index].senderId);
                      return MessageBubble(
                        bloc.messages[index].text ?? '',
                        isMe,
                        audioUrl: bloc.messages[index].audioUrl,
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
