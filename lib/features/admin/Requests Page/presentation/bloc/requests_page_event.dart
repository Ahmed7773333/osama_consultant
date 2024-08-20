// ignore_for_file: must_be_immutable

part of 'requests_page_bloc.dart';

abstract class RequestsPageEvent extends Equatable {
  const RequestsPageEvent();

  @override
  List<Object> get props => [];
}

class GetAllRequestsAdminEvent extends RequestsPageEvent {}

class GenerateRTCTokenAdminEvent extends RequestsPageEvent {}

class SetRequestAdminEvent extends RequestsPageEvent {
  final RequestModel request;
  SetRequestAdminEvent(this.request);
}

class AcceptRequestEvent extends RequestsPageEvent {
  int id;
  AcceptRequestEvent(this.id);
}

class RejecetRequestEvent extends RequestsPageEvent {
  int id;
  RejecetRequestEvent(this.id);
}
