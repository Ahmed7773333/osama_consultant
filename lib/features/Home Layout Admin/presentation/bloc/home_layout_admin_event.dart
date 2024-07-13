// ignore_for_file: public_member_api_docs, sort_constructors_first
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
