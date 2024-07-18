import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/network/firebase_helper.dart';
import '../../../user/HomeLayout/data/models/message.dart';

part 'chat_screen_event.dart';
part 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  List<MessageModel> messages = [];
  String filePath = '';
  bool isRecording = false;
  bool isPaused = false;
  bool isPlaying = false;
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();

  static ChatScreenBloc get(context) => BlocProvider.of(context);

  ChatScreenBloc() : super(ChatScreenInitial()) {
    on<ChatScreenEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      ChatScreenEvent event, Emitter<ChatScreenState> emit) async {
    if (event is InitRecorder) {
      await _initRecorder(emit);
    } else if (event is StartRecorder) {
      await _startRecorder(emit);
    } else if (event is PauseRecorder) {
      await _pauseRecorder(emit);
    } else if (event is ResumeRecorder) {
      await _resumeRecorder(emit);
    } else if (event is StopRecorder) {
      await _stopRecorder(emit);
    } else if (event is CloseEvent) {
      await _closeEvent(emit);
    } else if (event is GetChatMessagesEvent) {
      await _getChatMessagesEvent(event, emit);
    } else if (event is DeleteFilePathEvent) {
      deleteFilePath(emit);
    }
  }

  Future<void> _initRecorder(Emitter<ChatScreenState> emit) async {
    try {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
      await recorder
          .openRecorder()
          .whenComplete(() => emit(RecorderInitializedState()));
    } catch (e) {
      emit(RecorderErrorState(e.toString()));
    }
  }

  Future<void> _startRecorder(Emitter<ChatScreenState> emit) async {
    final dir = await getApplicationDocumentsDirectory();
    isRecording = true;
    filePath =
        '${dir.path}/audio_message_${DateTime.now().millisecondsSinceEpoch}.aac';
    await recorder
        .startRecorder(toFile: filePath)
        .whenComplete(() => emit(StartRecorderState()));
  }

  Future<void> _pauseRecorder(Emitter<ChatScreenState> emit) async {
    isPaused = true;
    await recorder
        .pauseRecorder()
        .whenComplete(() => emit(PauseRecorderState()));
  }

  Future<void> _resumeRecorder(Emitter<ChatScreenState> emit) async {
    isPaused = false;
    await recorder
        .resumeRecorder()
        .whenComplete(() => emit(ResumeRecorderState()));
  }

  Future<void> _stopRecorder(Emitter<ChatScreenState> emit) async {
    isRecording = false;
    await recorder.stopRecorder().whenComplete(() => emit(StopRecorderState()));
  }

  Future<void> _closeEvent(Emitter<ChatScreenState> emit) async {
    await recorder
        .closeRecorder()
        .whenComplete(() => emit(CloseRecorderState()));
  }

  Future<void> _getChatMessagesEvent(
      GetChatMessagesEvent event, Emitter<ChatScreenState> emit) async {
    try {
      emit(MessagessLoading());
      var snapshot = await FirebaseFirestore.instance
          .collection(FirebaseHelper.chatCollection)
          .doc(event.id)
          .collection(FirebaseHelper.messagesCollection)
          .orderBy(FirebaseHelper.time, descending: true)
          .get();
      messages =
          snapshot.docs.map((doc) => MessageModel.fromDocument(doc)).toList();
      emit(MessagessLoaded(messages));
    } catch (e) {
      emit(MessagessError(e.toString()));
    }
  }

  void deleteFilePath(emit) {
    filePath = '';
    emit(DeleteFilePathState());
  }

  @override
  Future<void> close() async {
    await recorder.closeRecorder();
    return super.close();
  }
}
