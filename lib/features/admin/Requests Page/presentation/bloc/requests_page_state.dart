part of 'requests_page_bloc.dart';

abstract class RequestsPageState extends Equatable {
  const RequestsPageState();

  @override
  List<Object> get props => [];
}

class RequestsPageInitial extends RequestsPageState {}

class LoadingAllRequestsState extends RequestsPageState {}

class ErrorAllRequestState extends RequestsPageState {}

class SuccessAllRequestState extends RequestsPageState {}
