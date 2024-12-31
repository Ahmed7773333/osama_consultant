// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'home_layout_admin_bloc.dart';

abstract class HomeLayoutAdminEvent extends Equatable {
  const HomeLayoutAdminEvent();

  @override
  List<Object> get props => [];
}

class GetAllChatsEvent extends HomeLayoutAdminEvent {}

class GetUnReadChatsEvent extends HomeLayoutAdminEvent {}

class LogoutAdminEvent extends HomeLayoutAdminEvent {}

class SearchChatsEvent extends HomeLayoutAdminEvent {
  final String searchQuery;

  SearchChatsEvent(this.searchQuery);
}

class AddQuoteEvent extends HomeLayoutAdminEvent {
  final String text;
  final String image;
  AddQuoteEvent(this.text, this.image);
}

class AddMemberEvent extends HomeLayoutAdminEvent {
  final String name;
  final String email;
  final String password;
  final int role;
  AddMemberEvent(
      {required this.name,
      required this.email,
      required this.password,
      required this.role});
}
