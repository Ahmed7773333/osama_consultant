// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';
import 'package:osama_consul/core/utils/app_animations.dart';
import 'package:osama_consul/core/utils/app_styles.dart';
import 'package:osama_consul/features/general/Chat%20Screen/presentation/bloc/chat_screen_bloc.dart';
import 'package:osama_consul/features/general/Chat%20Screen/data/models/chat_model.dart';
import 'package:osama_consul/features/general/Chat%20Screen/presentation/pages/buy_consultants.dart';
import 'package:osama_consul/features/general/Chat%20Screen/presentation/widgets/message_bubble.dart';

import '../../../../../core/network/check_internet.dart';
import '../../../../../core/network/firebase_helper.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../domain/usecases/send_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(this.id, this.fromAdmin, {super.key});
  final ChatModel id;
  final bool fromAdmin;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  ChatScreenBloc? bloc;
  int messagesLength = 0;
  int consultantCount = 0;
  @override
  void initState() {
    FirebaseHelper()
        .markAllMessagesAsReadAndResetUnreadCount(widget.id.chatOwner ?? '');
    setCount();
    super.initState();
  }

  void setCount() async {
    if (consultantCount !=
        ((await UserPreferences.getConsultantsCount()) ?? 0)) {
      consultantCount = (await UserPreferences.getConsultantsCount()) ?? 0;
      debugPrint('building');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    setCount();
    return BlocProvider(
      create: (context) => ChatScreenBloc()..add(InitRecorder()),
      child: BlocConsumer<ChatScreenBloc, ChatScreenState>(
        listener: (BuildContext context, ChatScreenState state) {},
        builder: (context, state) {
          bloc ??= ChatScreenBloc.get(context);
          FirebaseFirestore.instance
              .collection(FirebaseHelper.chatCollection)
              .doc(widget.id.chatOwner ?? '')
              .collection(FirebaseHelper.messagesCollection)
              .orderBy(FirebaseHelper.time, descending: false)
              .snapshots()
              .listen((snapshot) {
            if (messagesLength < snapshot.docs.length) {
              messagesLength = snapshot.docs.length;
              bloc!.add(GetChatMessagesEvent(widget.id.chatOwner ?? ''));
            }
          });
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () async {
                  bloc!.add(CloseEvent());
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
              title: Text(
                widget.id.chatName ?? "",
                style: AppStyles.welcomeSytle,
              ),
              actions: [
                if (!widget.fromAdmin)
                  TextButton(
                    child: Text('Consultants: ${consultantCount}  +',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(context, TopRouting(BuyConsultants()));
                    },
                  )
              ],
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: bloc!.messages.length,
                    itemBuilder: (ctx, index) {
                      final isMe = (widget.id.chatOwner ?? '') ==
                          (bloc!.messages[index].senderId);
                      return MessageBubble(
                        bloc!.messages[index].text ?? '',
                        isMe,
                        audioUrl: bloc!.messages[index].audioUrl,
                      );
                    },
                  ),
                ),
                if (bloc!.filePath.isNotEmpty && !bloc!.isRecording)
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Test',
                          style: AppStyles.erorStyle,
                        ),
                        MessageBubble('', true,
                            audioUrl: bloc!.filePath, isfile: true),
                        IconButton(
                          onPressed: () {
                            bloc!.add(DeleteFilePathEvent());
                          },
                          icon: const Icon(Icons.delete,
                              color: AppColors.secondry),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: TextField(
                    controller: _controller,
                    maxLines: 3,
                    maxLength: 1000,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondry)),
                      labelText: 'Send a message...',
                      labelStyle: const TextStyle(color: AppColors.secondry),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (bloc!.isRecording)
                      Row(
                        children: [
                          const Icon(Icons.fiber_manual_record,
                              color: AppColors.secondry),
                          SizedBox(width: 8.w),
                          Text(
                            bloc!.isPaused
                                ? 'Recording Paused'
                                : 'Recording...',
                            style: const TextStyle(color: AppColors.secondry),
                          ),
                        ],
                      )
                    else
                      IconButton(
                        icon: const Icon(
                          Icons.mic,
                          color: AppColors.secondry,
                        ),
                        onPressed: () => bloc!.add(StartRecorder()),
                      ),
                    if (bloc!.isRecording)
                      IconButton(
                        icon: bloc!.isPaused
                            ? const Icon(
                                Icons.play_arrow,
                                color: AppColors.secondry,
                              )
                            : const Icon(
                                Icons.pause,
                                color: AppColors.secondry,
                              ),
                        onPressed: bloc!.isPaused
                            ? () => bloc!.add(ResumeRecorder())
                            : () => bloc!.add(PauseRecorder()),
                      ),
                    if (bloc!.isRecording)
                      IconButton(
                        icon: const Icon(
                          Icons.stop,
                          color: AppColors.secondry,
                        ),
                        onPressed: () => bloc!.add(StopRecorder()),
                      ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: AppColors.secondry,
                      ),
                      onPressed: () async {
                        if (!bloc!.isRecording) {
                          bool isConnect =
                              await ConnectivityService().getConnectionStatus();
                          if (isConnect) {
                            await sendMessage(bloc!.filePath, _controller,
                                context, widget.id.chatOwner, widget.fromAdmin);
                            bloc!.add(DeleteFilePathEvent());
                            setState(() {});
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
