part of 'requests_page_bloc.dart';

abstract class RequestsPageState extends Equatable {
  const RequestsPageState();

  @override
  List<Object> get props => [];
}

class RequestsPageInitial extends RequestsPageState {}

class LoadingAllRequestsState extends RequestsPageState {}

class LoadingSetRequestState extends RequestsPageState {}

class SetRequestAdminSuccessState extends RequestsPageState {}

class ErrorAllRequestState extends RequestsPageState {}

class SuccessAllRequestState extends RequestsPageState {}

class LoadingOrderState extends RequestsPageState {}

class ErrorOrderState extends RequestsPageState {}

class AcceptOrderState extends RequestsPageState {}

class RejectOrderState extends RequestsPageState {}

class ErrorGenerateRtcTokenState extends RequestsPageState {}

class LoadingGenerateRtcTokenState extends RequestsPageState {}

class SuccessGenerateRtcTokenState extends RequestsPageState {}
