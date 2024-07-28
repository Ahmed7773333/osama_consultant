// ignore_for_file: must_be_immutable

part of 'homelayout_bloc.dart';

abstract class HomelayoutEvent extends Equatable {
  const HomelayoutEvent();

  @override
  List<Object> get props => [];
}

class ConfirmBookingEvent extends HomelayoutEvent {}

class LogoutEvent extends HomelayoutEvent {}

class GetNotificationsEvent extends HomelayoutEvent {}

class GetAllSchedulesUserEvent extends HomelayoutEvent {}

class GetScheduleByIdUserEvent extends HomelayoutEvent {
  int id;
  GetScheduleByIdUserEvent(this.id);
}

class GetSlotByIdUserEvent extends HomelayoutEvent {
  int id;
  GetSlotByIdUserEvent(this.id);
}
