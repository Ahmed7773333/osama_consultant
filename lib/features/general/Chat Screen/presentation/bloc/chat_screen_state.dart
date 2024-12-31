// ignore_for_file: must_be_immutable

part of 'chat_screen_bloc.dart';

abstract class ChatScreenState extends Equatable {
  const ChatScreenState();

  @override
  List<Object> get props => [];
}

class ChatScreenInitial extends ChatScreenState {}

class StartRecorderState extends ChatScreenState {}

class StopRecorderState extends ChatScreenState {}

class PauseRecorderState extends ChatScreenState {}

class ResumeRecorderState extends ChatScreenState {}

class RecorderInitializedState extends ChatScreenState {}

class RecorderInitializedLoadingState extends ChatScreenState {}

class CloseRecorderState extends ChatScreenState {}

class DeleteFilePathState extends ChatScreenState {}

class SendLoadingMessage extends ChatScreenState {}

class SendSuccessMessage extends ChatScreenState {}

class SendErrorMessage extends ChatScreenState {
  String error;
  SendErrorMessage(this.error);
}

class RecorderErrorState extends ChatScreenState {
  String error;
  RecorderErrorState(this.error);
}

class MessagessLoaded extends ChatScreenState {
  final List<MessageModel> messageschats;
  const MessagessLoaded(this.messageschats);

  @override
  List<Object> get props => [messageschats];
}

class MessagessLoading extends ChatScreenState {}

class MessagessError extends ChatScreenState {
  final String error;
  const MessagessError(this.error);

  @override
  List<Object> get props => [error];
}

class UpdateIsOpenedLoading extends ChatScreenState {}

class UpdateIsOpenedError extends ChatScreenState {}

class UpdateIsOpenedSuccsess extends ChatScreenState {}
