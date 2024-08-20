// ignore_for_file: must_be_immutable

part of 'meetings_control_bloc.dart';

abstract class MeetingsControlState extends Equatable {
  const MeetingsControlState();

  @override
  List<Object> get props => [];
}

class MeetingsControlInitial extends MeetingsControlState {}

class GettingLoadingState extends MeetingsControlState {}

class AddLoadingState extends MeetingsControlState {}

class GeetingAllSuccessState extends MeetingsControlState {
  List<ScheduleModel> scedules;
  GeetingAllSuccessState(this.scedules);
}

class GeetingbyIdSuccessState extends MeetingsControlState {
  List<SlotModel> slots;
  GeetingbyIdSuccessState(this.slots);
}

class GettingErrorState extends MeetingsControlState {
  Failures l;
  GettingErrorState(this.l);
}

class AddErrorState extends MeetingsControlState {
  Failures l;
  AddErrorState(this.l);
}

class AddSuccessState extends MeetingsControlState {}

class GetSlotByIdLoading extends MeetingsControlState {}

class GetSlotByIdSuccessState extends MeetingsControlState {}

class DeleteSlotByIdLoading extends MeetingsControlState {}

class DeleteSlotByIdSuccessState extends MeetingsControlState {}

class DeleteSlotByIdErrorState extends MeetingsControlState {}
