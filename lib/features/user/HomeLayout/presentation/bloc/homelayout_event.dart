// ignore_for_file: must_be_immutable

part of 'homelayout_bloc.dart';

abstract class HomelayoutEvent extends Equatable {
  const HomelayoutEvent();

  @override
  List<Object> get props => [];
}

class PickDateEvent extends HomelayoutEvent {
  final DateTime date;

  const PickDateEvent(this.date);

  @override
  List<Object> get props => [date];
}

class PickTimeEvent extends HomelayoutEvent {
  final TimeOfDay time;

  const PickTimeEvent(this.time);

  @override
  List<Object> get props => [time];
}

class PickDurationEvent extends HomelayoutEvent {
  final Duration duration;

  const PickDurationEvent(this.duration);

  @override
  List<Object> get props => [duration];
}

class PickNotificationDurationEvent extends HomelayoutEvent {
  final Duration duration;

  const PickNotificationDurationEvent(this.duration);

  @override
  List<Object> get props => [duration];
}

class ConfirmBookingEvent extends HomelayoutEvent {
  final BuildContext context;

  const ConfirmBookingEvent(this.context);
}

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
