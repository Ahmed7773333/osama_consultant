import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/core/network/firebase_helper.dart';
import 'package:osama_consul/features/Home%20Layout%20Admin/data/models/chat_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../HomeLayout/data/models/message.dart';

part 'home_layout_admin_event.dart';
part 'home_layout_admin_state.dart';

class HomeLayoutAdminBloc
    extends Bloc<HomeLayoutAdminEvent, HomeLayoutAdminState> {
  List<ChatModel> chats = [];
  List<MessageModel> messages = [];
  String filePath = '';
  bool isRecording = false;
  bool isPaused = false;
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();

  static HomeLayoutAdminBloc get(context) => BlocProvider.of(context);

  HomeLayoutAdminBloc() : super(HomeLayoutAdminInitial()) {
    on<HomeLayoutAdminEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      HomeLayoutAdminEvent event, Emitter<HomeLayoutAdminState> emit) async {
    if (event is InitRecorder) {
      await _initRecorder(emit);
    } else if (event is ListenToPlayer) {
      _listenToPlayer(emit);
      emit(UpdatePositionState(position, duration));
    } else if (event is TogglePlayPause) {
      await _togglePlayPause(emit);
    } else if (event is SeekTo) {
      await _seekTo(event, emit);
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
    } else if (event is GetChatsEvent) {
      await _getChatsEvent(emit);
    } else if (event is GetChatMessagesEvent) {
      await _getChatMessagesEvent(event, emit);
    }
  }

  Future<void> _initRecorder(Emitter<HomeLayoutAdminState> emit) async {
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

  void _listenToPlayer(Emitter<HomeLayoutAdminState> emit) {
    audioPlayer.positionStream.listen((position) {
      this.position = position;
    });

    audioPlayer.durationStream.listen((duration) {
      this.duration = duration ?? Duration.zero;
    });

    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        isPlaying = false;
        position = Duration.zero;
      }
    });
  }

  Future<void> _togglePlayPause(Emitter<HomeLayoutAdminState> emit) async {
    if (isPlaying) {
      isPlaying = false;
      await audioPlayer.pause().whenComplete(() => emit(PauseState()));
    } else {
      isPlaying = true;
      if (audioPlayer.audioSource == null) {
        await audioPlayer.setFilePath(filePath);
      }
      await audioPlayer.play().whenComplete(() => emit(ResumeState()));
    }
  }

  Future<void> _seekTo(SeekTo event, Emitter<HomeLayoutAdminState> emit) async {
    position = Duration(milliseconds: event.position.toInt());
    await audioPlayer
        .seek(position)
        .whenComplete(() => emit(UpdatePositionState(position, duration)));
  }

  Future<void> _startRecorder(Emitter<HomeLayoutAdminState> emit) async {
    final dir = await getApplicationDocumentsDirectory();
    isRecording = true;
    filePath =
        '${dir.path}/audio_message_${DateTime.now().millisecondsSinceEpoch}.aac';
    await recorder
        .startRecorder(toFile: filePath)
        .whenComplete(() => emit(StartRecorderState()));
  }

  Future<void> _pauseRecorder(Emitter<HomeLayoutAdminState> emit) async {
    isPaused = true;
    await recorder
        .pauseRecorder()
        .whenComplete(() => emit(PauseRecorderState()));
  }

  Future<void> _resumeRecorder(Emitter<HomeLayoutAdminState> emit) async {
    isPaused = false;
    await recorder
        .resumeRecorder()
        .whenComplete(() => emit(ResumeRecorderState()));
  }

  Future<void> _stopRecorder(Emitter<HomeLayoutAdminState> emit) async {
    isRecording = false;
    await recorder.stopRecorder().whenComplete(() => emit(StopRecorderState()));
  }

  Future<void> _closeEvent(Emitter<HomeLayoutAdminState> emit) async {
    await recorder
        .closeRecorder()
        .whenComplete(() => emit(CloseRecorderState()));
    await audioPlayer.dispose().whenComplete(() => emit(ClosePlayerState()));
  }

  Future<void> _getChatsEvent(Emitter<HomeLayoutAdminState> emit) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection(FirebaseHelper.chatCollection)
          .get();
      chats = snapshot.docs.map((doc) => ChatModel.fromDocument(doc)).toList();
      emit(ChatsLoaded(chats));
    } catch (e) {
      emit(ChatsError(e.toString()));
    }
  }

  Future<void> _getChatMessagesEvent(
      GetChatMessagesEvent event, Emitter<HomeLayoutAdminState> emit) async {
    try {
      emit(LoadingState());
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

  @override
  Future<void> close() async {
    await recorder.closeRecorder();
    await audioPlayer.dispose();
    return super.close();
  }
}
