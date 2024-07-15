part of 'chat_screen_bloc.dart';

abstract class ChatScreenEvent extends Equatable {
  const ChatScreenEvent();

  @override
  List<Object> get props => [];
}

class CloseEvent extends ChatScreenEvent {}

class InitRecorder extends ChatScreenEvent {}

class ResumeRecorder extends ChatScreenEvent {}

class StopRecorder extends ChatScreenEvent {}

class StartRecorder extends ChatScreenEvent {}

class PauseRecorder extends ChatScreenEvent {}

class DeleteFilePathEvent extends ChatScreenEvent {}

class GetChatMessagesEvent extends ChatScreenEvent {
  final String id;
  const GetChatMessagesEvent(
    this.id,
  );
}
