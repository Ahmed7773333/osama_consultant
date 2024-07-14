// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'home_layout_admin_bloc.dart';

abstract class HomeLayoutAdminEvent extends Equatable {
  const HomeLayoutAdminEvent();

  @override
  List<Object> get props => [];
}

class GetChatsEvent extends HomeLayoutAdminEvent {}

class GetChatMessagesEvent extends HomeLayoutAdminEvent {
  final String id;
  const GetChatMessagesEvent(
    this.id,
  );
}

class ListenToPlayer extends HomeLayoutAdminEvent {}

class SeekTo extends HomeLayoutAdminEvent {
  double position;
  SeekTo(this.position);
}

class TogglePlayPause extends HomeLayoutAdminEvent {}

class CloseEvent extends HomeLayoutAdminEvent {}

class InitRecorder extends HomeLayoutAdminEvent {}

class ResumeRecorder extends HomeLayoutAdminEvent {}

class StopRecorder extends HomeLayoutAdminEvent {}

class StartRecorder extends HomeLayoutAdminEvent {}

class PauseRecorder extends HomeLayoutAdminEvent {}
