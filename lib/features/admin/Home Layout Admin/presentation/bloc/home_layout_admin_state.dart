// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'home_layout_admin_bloc.dart';

abstract class HomeLayoutAdminState extends Equatable {
  const HomeLayoutAdminState();

  @override
  List<Object> get props => [];
}

class HomeLayoutAdminInitial extends HomeLayoutAdminState {}

class LoadingState extends HomeLayoutAdminState {}

class AllChatsSuccessState extends HomeLayoutAdminState {}

class AllChatsLoadingState extends HomeLayoutAdminState {}

class SearchChatsLoadingState extends HomeLayoutAdminState {}

class UnReadChatsSuccessState extends HomeLayoutAdminState {}

class UnReadChatsLoadingState extends HomeLayoutAdminState {}

class ChatsError extends HomeLayoutAdminState {
  final String error;
  const ChatsError(this.error);

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

class LogoutAdminLoadingState extends HomeLayoutAdminState {}

class LogoutAdminErrorState extends HomeLayoutAdminState {}

class LogoutAdminSuccessState extends HomeLayoutAdminState {}

class SearchChatsState extends HomeLayoutAdminState {
  final List<ChatModel> filteredChats;

  SearchChatsState(this.filteredChats);
}

class AddQuoteLoadingState extends HomeLayoutAdminState {}

class AddQuoteSuccessState extends HomeLayoutAdminState {}

class AddQuoteErrorState extends HomeLayoutAdminState {}

class AddMemberLoadingState extends HomeLayoutAdminState {}

class AddMemberSuccessState extends HomeLayoutAdminState {}

class AddMemberErrorState extends HomeLayoutAdminState {}
