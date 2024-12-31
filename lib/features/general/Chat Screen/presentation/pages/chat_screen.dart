// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';
import 'package:osama_consul/core/utils/app_styles.dart';
import 'package:osama_consul/core/utils/assets.dart';
import 'package:osama_consul/core/utils/componetns.dart';
import 'package:osama_consul/features/general/Chat%20Screen/presentation/bloc/chat_screen_bloc.dart';
import 'package:osama_consul/features/general/Chat%20Screen/data/models/chat_model.dart';
import 'package:osama_consul/features/general/Chat%20Screen/presentation/widgets/message_bubble.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/network/check_internet.dart';
import '../../../../../core/network/firebase_helper.dart';
import '../../../../../core/utils/app_colors.dart';
import 'package:showcaseview/showcaseview.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(this.id, this.isAdmin, {super.key});
  final ChatModel id;
  final bool isAdmin;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  ChatScreenBloc? bloc;
  int messagesLength = 0;
  final GlobalKey recordKey = GlobalKey();
  final GlobalKey payKey = GlobalKey();
  final GlobalKey openChatKey = GlobalKey();

  final GlobalKey countKey = GlobalKey();
  final GlobalKey pauseKey = GlobalKey();
  final GlobalKey stopKey = GlobalKey();

  @override
  void initState() {
    FirebaseHelper()
        .markAllMessagesAsReadAndResetUnreadCount(widget.id.chatOwner ?? '');

    _checkFirstTime();
    super.initState();
  }

  void showCasse() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context)
          .startShowCase([payKey, countKey, recordKey, pauseKey, stopKey]);
    });
  }

  Future<void> _checkFirstTime() async {
    bool isFirstTime = await UserPreferences.getShowCase() ?? true;

    if (isFirstTime && !widget.isAdmin) {
      // Start showcase if this is the first time
      showCasse();

      // Set the flag so that showcase is not shown next time
      await UserPreferences.setShowCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => ChatScreenBloc()
        ..add(InitRecorder(isopend: widget.id.isOpened ?? false)),
      child: BlocConsumer<ChatScreenBloc, ChatScreenState>(
        listener: (BuildContext context, ChatScreenState state) {
          if (state is SendLoadingMessage) {
            Components.circularProgressHeart(context);
          } else if (state is SendSuccessMessage) {
            Navigator.pop(context);
          } else if (state is SendErrorMessage) {
            Navigator.pop(context);
            Components.showMessage(context,
                content: state.error,
                icon: Icons.error,
                color: Color(0xffc02829));
          }
        },
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
                  if (widget.isAdmin) {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.homeLayoutAdmin,
                      arguments: {'page': 1},
                    );
                  } else {
                    bloc!.add(CloseEvent());
                    Navigator.pop(context);
                  }
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20.r,
                ),
              ),
              title: Showcase(
                key: openChatKey,
                description: localizations.openButtonDescription,
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          bloc!.add(UpdateIsOpenedEvent(
                              widget.id.chatOwner ?? "", widget.isAdmin));
                        },
                        child: Text(
                          (bloc!.isOpened && widget.isAdmin)
                              ? localizations.closeChatting
                              : localizations.startChatting,
                          style: TextStyle(fontSize: 10.sp),
                        )),
                    Image.asset(
                      (bloc!.isOpened) ? Assets.on : Assets.off,
                      width: 30.w,
                      height: 20.h,
                    ),
                  ],
                ),
              ),
              actions: [
                if (!widget.isAdmin)
                  Row(
                    children: [
                      Showcase(
                        key: countKey,
                        description: localizations.consultantsCountDescription,
                        child: Text(
                            '${localizations.consultants} ${bloc!.consultantCount}  ',
                            style: TextStyle(color: Colors.white)),
                      ),
                      Showcase(
                        key: payKey,
                        description: localizations.payButtonDescription,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.paymentMethods);
                            },
                            icon: Image.asset(Assets.coin)),
                      ),
                    ],
                  ),
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
                    color: AppColors.secondry,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          localizations.test,
                          style: AppStyles.erorStyle,
                        ),
                        MessageBubble('', true,
                            audioUrl: bloc!.filePath, isfile: true),
                        IconButton(
                          onPressed: () {
                            bloc!.add(DeleteFilePathEvent());
                          },
                          icon: const Icon(Icons.delete,
                              color: AppColors.onPrimary),
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
                          borderSide: BorderSide(color: AppColors.onPrimary)),
                      labelText: localizations.sendMessage,
                      labelStyle: const TextStyle(color: AppColors.onPrimary),
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
                              color: AppColors.onPrimary),
                          SizedBox(width: 8.w),
                          Text(
                            bloc!.isPaused
                                ? localizations.recordingPaused
                                : localizations.recording,
                            style: const TextStyle(color: AppColors.onPrimary),
                          ),
                        ],
                      )
                    else
                      Showcase(
                        key: recordKey,
                        description: localizations.recordButtonDescription,
                        child: IconButton(
                          icon: const Icon(
                            Icons.mic,
                            color: AppColors.onPrimary,
                          ),
                          onPressed: () => bloc!.add(StartRecorder()),
                        ),
                      ),
                    if (bloc!.isRecording)
                      Showcase(
                        key: pauseKey,
                        description: localizations.pauseButtonDescription,
                        child: IconButton(
                          icon: bloc!.isPaused
                              ? const Icon(
                                  Icons.play_arrow,
                                  color: AppColors.onPrimary,
                                )
                              : const Icon(
                                  Icons.pause,
                                  color: AppColors.onPrimary,
                                ),
                          onPressed: bloc!.isPaused
                              ? () => bloc!.add(ResumeRecorder())
                              : () => bloc!.add(PauseRecorder()),
                        ),
                      ),
                    if (bloc!.isRecording)
                      Showcase(
                        key: stopKey,
                        description: localizations.stopButtonDescription,
                        child: IconButton(
                          icon: const Icon(
                            Icons.stop,
                            color: AppColors.onPrimary,
                          ),
                          onPressed: () => bloc!.add(StopRecorder()),
                        ),
                      ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: AppColors.onPrimary,
                      ),
                      onPressed: () async {
                        if (!bloc!.isRecording) {
                          bool isConnect =
                              await ConnectivityService().getConnectionStatus();
                          if (isConnect) {
                            bloc!.add(SendEvent(bloc!.filePath, _controller,
                                context, widget.id.chatOwner, widget.isAdmin));
                            bloc!.add(DeleteFilePathEvent());
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
