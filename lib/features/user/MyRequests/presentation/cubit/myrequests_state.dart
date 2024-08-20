// ignore_for_file: must_be_immutable

part of 'myrequests_cubit.dart';

abstract class MyrequestsState extends Equatable {
  const MyrequestsState();

  @override
  List<Object> get props => [];
}

class MyrequestsInitial extends MyrequestsState {}

class LoadingSetRequestState extends MyrequestsState {}

class SuccessSetRequestState extends MyrequestsState {}

class LoadingMyRequestsState extends MyrequestsState {}

class SuccessMyRequestState extends MyrequestsState {}

class ErrorMyRequestState extends MyrequestsState {}

class LoadingAuthTokenPaymentState extends MyrequestsState {}

class SuccessAuthTokenPaymentState extends MyrequestsState {}

class ErrorAuthTokenPaymentState extends MyrequestsState {}

class LoadingOrderIdPaymentState extends MyrequestsState {}

class SuccessOrderIdPaymentState extends MyrequestsState {}

class ErrorOrderIdPaymentState extends MyrequestsState {}

class LoadingRequestTokenCardPaymentState extends MyrequestsState {}

class SuccessRequestTokenCardPaymentState extends MyrequestsState {
  int id;
  SuccessRequestTokenCardPaymentState(this.id);
}

class ErrorRequestTokenCardPaymentState extends MyrequestsState {}

class LoadingReferenceCodePaymentState extends MyrequestsState {}

class SuccessReferenceCodePaymentState extends MyrequestsState {}

class ErrorReferenceCodePaymentState extends MyrequestsState {}

class LoadingSendTransactionState extends MyrequestsState {}

class SuccessSendTransactionState extends MyrequestsState {}

class ErrorSendTransactionState extends MyrequestsState {}

class LoadingStoreConusltantState extends MyrequestsState {}

class SuccessStoreConusltantState extends MyrequestsState {}

class ErrorStoreConusltantState extends MyrequestsState {}
