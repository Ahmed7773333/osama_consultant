// ignore_for_file: must_be_immutable

part of 'meetings_control_bloc.dart';

abstract class MeetingsControlEvent extends Equatable {
  const MeetingsControlEvent();

  @override
  List<Object> get props => [];
}

class GetAllSchedulesEvent extends MeetingsControlEvent {}

class GetScheduleByIdEvent extends MeetingsControlEvent {
  int id;
  GetScheduleByIdEvent(this.id);
}

class AddSlotEvent extends MeetingsControlEvent {
  SlotToAdd slot;
  AddSlotEvent(this.slot);
}

class GetSlotByIdEvent extends MeetingsControlEvent {
  int id;
  GetSlotByIdEvent(this.id);
}
