// ignore_for_file: must_be_immutable

part of 'homelayout_bloc.dart';

abstract class HomelayoutEvent extends Equatable {
  const HomelayoutEvent();

  @override
  List<Object> get props => [];
}

class LogoutEvent extends HomelayoutEvent {}

class GetNotificationsEvent extends HomelayoutEvent {}
class GetQuotesEvent extends HomelayoutEvent {}
