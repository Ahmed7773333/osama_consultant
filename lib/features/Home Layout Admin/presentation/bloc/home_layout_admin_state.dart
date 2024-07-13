// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'home_layout_admin_bloc.dart';

abstract class HomeLayoutAdminState extends Equatable {
  const HomeLayoutAdminState();

  @override
  List<Object> get props => [];
}

class HomeLayoutAdminInitial extends HomeLayoutAdminState {}

class LoadingState extends HomeLayoutAdminState {}

class ChatsLoaded extends HomeLayoutAdminState {
  final List<ChatModel> chats;
  const ChatsLoaded(this.chats);

  @override
  List<Object> get props => [chats];
}

class ChatsError extends HomeLayoutAdminState {
  final String error;
  const ChatsError(this.error);

  @override
  List<Object> get props => [error];
}

class MessagessLoaded extends HomeLayoutAdminState {
  final List<MessageModel> messageschats;
  const MessagessLoaded(this.messageschats);

  @override
  List<Object> get props => [messageschats];
}

class MessagessError extends HomeLayoutAdminState {
  final String error;
  const MessagessError(this.error);

  @override
  List<Object> get props => [error];
}

class ErrorState extends HomeLayoutAdminState {
  Failures l;
  ErrorState(
    this.l,
  );
}

class SccussState extends HomeLayoutAdminState {}
