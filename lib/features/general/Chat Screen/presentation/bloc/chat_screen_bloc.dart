import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import '../../../../../core/api/api_manager.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/network/firebase_helper.dart';
import '../../data/models/message.dart';
import '../../domain/usecases/send_message.dart';

part 'chat_screen_event.dart';
part 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  List<MessageModel> messages = [];
  String filePath = '';
  bool isRecording = false;
  bool isPaused = false;
  bool isPlaying = false;
  final AudioRecorder recorder = AudioRecorder();
  bool isOpened = false;
  int consultantCount = 0;

  Stopwatch? _stopwatch;
  int _maxRecordingDuration = 600; // Max duration in seconds (3 minutes)
  Timer? _durationChecker;

  static ChatScreenBloc get(context) => BlocProvider.of(context);

  ChatScreenBloc() : super(ChatScreenInitial()) {
    on<ChatScreenEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      ChatScreenEvent event, Emitter<ChatScreenState> emit) async {
    if (event is InitRecorder) {
      await _initRecorder(emit, event);
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
    } else if (event is UpdateIsOpenedEvent) {
      await _updateIsOpened(event, emit);
    } else if (event is DeleteFilePathEvent) {
      deleteFilePath(emit);
    } else if (event is SendEvent) {
      try {
        emit(SendLoadingMessage());
        await sendMessage(event.filePath, event.controller, event.context,
            event.chatOwner, event.fromAdmin);
        emit(SendSuccessMessage());
      } catch (e) {
        emit(SendErrorMessage(e.toString()));
      }
      deleteFilePath(emit);
    }
  }

  Future<void> _initRecorder(
      Emitter<ChatScreenState> emit, InitRecorder event) async {
    try {
      emit(RecorderInitializedLoadingState());
      final status = await Permission.microphone.request();
      isOpened = event.isopend;
      if (consultantCount !=
          ((await UserPreferences.getConsultantsCount()) ?? 0)) {
        consultantCount = (await UserPreferences.getConsultantsCount()) ?? 0;
      }
      if (status != PermissionStatus.granted) {
        throw Exception('Microphone permission not granted');
      }
      emit(RecorderInitializedState());
    } catch (e) {
      emit(RecorderErrorState(e.toString()));
    }
  }

  Future<void> _startRecorder(Emitter<ChatScreenState> emit) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      isRecording = true;
      filePath =
          '${dir.path}/audio_message_${DateTime.now().millisecondsSinceEpoch}.aac';

      if (await recorder.hasPermission()) {
        await recorder.start(const RecordConfig(), path: filePath);
        _startStopwatch(); // Start the stopwatch when recording starts
        emit(StartRecorderState());
      }
    } catch (e) {
      emit(RecorderErrorState(e.toString()));
    }
  }

  Future<void> _pauseRecorder(Emitter<ChatScreenState> emit) async {
    try {
      isPaused = true;
      await recorder.pause();
      _stopwatch?.stop(); // Pause the stopwatch
      emit(PauseRecorderState());
    } catch (e) {
      emit(RecorderErrorState(e.toString()));
    }
  }

  Future<void> _resumeRecorder(Emitter<ChatScreenState> emit) async {
    try {
      isPaused = false;
      await recorder.resume();
      _stopwatch?.start(); // Resume the stopwatch
      emit(ResumeRecorderState());
    } catch (e) {
      emit(RecorderErrorState(e.toString()));
    }
  }

  Future<void> _stopRecorder(Emitter<ChatScreenState> emit) async {
    try {
      isRecording = false;
      await recorder.stop();
      _stopStopwatch(); // Stop the stopwatch and reset
      emit(StopRecorderState());
    } catch (e) {
      emit(RecorderErrorState(e.toString()));
    }
  }

  Future<void> _closeEvent(Emitter<ChatScreenState> emit) async {
    try {
      close();
      emit(CloseRecorderState());
    } catch (e) {
      emit(RecorderErrorState(e.toString()));
    }
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

  Future<void> _updateIsOpened(
      UpdateIsOpenedEvent event, Emitter<ChatScreenState> emit) async {
    try {
      emit(UpdateIsOpenedLoading());
      bool isOpen = (await FirebaseHelper().getIsOpened(event.id));
      if (event.isAdmin) {
        await FirebaseFirestore.instance
            .collection(FirebaseHelper.chatCollection)
            .doc(event.id)
            .update({FirebaseHelper.isOpened: !isOpen});
        isOpened = !isOpened;
      } else {
        if (!isOpen) {
          _decreaseConsultantCount(await _getConsultantCount());
          consultantCount--;
          await FirebaseFirestore.instance
              .collection(FirebaseHelper.chatCollection)
              .doc(event.id)
              .update({FirebaseHelper.isOpened: true});
          isOpened = true;
        }
      }
      emit(UpdateIsOpenedSuccsess());
    } catch (e) {
      emit(UpdateIsOpenedError());
    }
  }

  Future<int> _getConsultantCount() async {
    return await UserPreferences.getConsultantsCount() ?? 0;
  }

// Decrease the consultant count and update user preferences
  Future<void> _decreaseConsultantCount(int consultantCount) async {
    consultantCount--;
    UserPreferences.setConsultantCount(consultantCount);
    await ApiManager().deleteData(
      EndPoints.consultantMinus,
      data: {'Authorization': 'Bearer ${await UserPreferences.getToken()}'},
    );
  }

  void deleteFilePath(emit) {
    filePath = '';
    emit(DeleteFilePathState());
  }

  // Stopwatch-related logic to handle pause and resume
  void _startStopwatch() async {
    _stopwatch = Stopwatch();
    _stopwatch?.start();
    final bool isAdmin = ((await UserPreferences.getIsAdmin()) ?? 0) == 1;
    // Periodically check if max recording duration has been reached
    _durationChecker = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_stopwatch!.elapsed.inSeconds >= _maxRecordingDuration && !isAdmin) {
        add(StopRecorder()); // Automatically stop the recording
        timer.cancel(); // Stop the periodic checks
      }
    });
  }

  void _stopStopwatch() {
    _stopwatch?.stop();
    _stopwatch?.reset();
    _durationChecker?.cancel(); // Cancel the periodic timer
  }

  @override
  Future<void> close() {
    recorder.dispose();
    _stopStopwatch(); // Stop the stopwatch and any periodic checks
    return super.close();
  }
}
