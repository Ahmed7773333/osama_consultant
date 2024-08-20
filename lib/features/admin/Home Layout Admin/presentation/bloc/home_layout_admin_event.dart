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
