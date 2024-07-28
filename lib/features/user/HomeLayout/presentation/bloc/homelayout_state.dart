// ignore_for_file: must_be_immutable

part of 'homelayout_bloc.dart';

abstract class HomelayoutState extends Equatable {
  const HomelayoutState();

  @override
  List<Object> get props => [];
}

class HomelayoutInitial extends HomelayoutState {}

class LogoutLoadingState extends HomelayoutState {}

class LogoutErrorState extends HomelayoutState {}

class LogoutSuccessState extends HomelayoutState {}

class HomelayoutLoading extends HomelayoutState {}

class GetSlotByIdUserLoading extends HomelayoutState {}

class GetScheduleByIdUserLoading extends HomelayoutState {}

class ChatLoaded extends HomelayoutState {}

class ChatError extends HomelayoutState {
  final String error;
  const ChatError(this.error);

  @override
  List<Object> get props => [error];
}

class BookingConfirmedLoadingState extends HomelayoutState {}

class BookingConfirmedState extends HomelayoutState {}

class BookingConfirmedErrorState extends HomelayoutState {
  final Failures error;
  const BookingConfirmedErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class GeetingAllUserSuccessState extends HomelayoutState {
  List<ScheduleModel> scedules;
  GeetingAllUserSuccessState(this.scedules);
}

class GetScheduleByIdUserSuccessState extends HomelayoutState {}

class GetSlotByIdUserSuccessState extends HomelayoutState {}

class GettingErrorUserState extends HomelayoutState {
  Failures l;
  GettingErrorUserState(this.l);
}
