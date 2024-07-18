part of 'homelayout_bloc.dart';

abstract class HomelayoutState extends Equatable {
  const HomelayoutState();

  @override
  List<Object> get props => [];
}

class HomelayoutInitial extends HomelayoutState {}

class DatePickedState extends HomelayoutState {
  final DateTime date;

  const DatePickedState(this.date);

  @override
  List<Object> get props => [date];
}

class TimePickedState extends HomelayoutState {
  final TimeOfDay time;

  const TimePickedState(this.time);

  @override
  List<Object> get props => [time];
}

class DurationPickedState extends HomelayoutState {
  final Duration duration;

  const DurationPickedState(this.duration);

  @override
  List<Object> get props => [duration];
}

class NotificationDurationPickedState extends HomelayoutState {
  final Duration duration;

  const NotificationDurationPickedState(this.duration);

  @override
  List<Object> get props => [duration];
}

class ChatLoaded extends HomelayoutState {}

class ChatError extends HomelayoutState {
  final String error;
  const ChatError(this.error);

  @override
  List<Object> get props => [error];
}

class BookingConfirmedState extends HomelayoutState {
  final DateTime meetingDateTime;
  final Duration meetingDuration;
  final Duration notificationDuration;

  const BookingConfirmedState(
    this.meetingDateTime,
    this.meetingDuration,
    this.notificationDuration,
  );

  @override
  List<Object> get props =>
      [meetingDateTime, meetingDuration, notificationDuration];
}
