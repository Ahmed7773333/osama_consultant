part of 'myrequests_cubit.dart';

abstract class MyrequestsState extends Equatable {
  const MyrequestsState();

  @override
  List<Object> get props => [];
}

class MyrequestsInitial extends MyrequestsState {}

class LoadingAuthTokenPaymentState extends MyrequestsState {}

class SuccessAuthTokenPaymentState extends MyrequestsState {}

class ErrorAuthTokenPaymentState extends MyrequestsState {}

class LoadingOrderIdPaymentState extends MyrequestsState {}

class SuccessOrderIdPaymentState extends MyrequestsState {}

class ErrorOrderIdPaymentState extends MyrequestsState {}

class LoadingRequestTokenCardPaymentState extends MyrequestsState {}

class SuccessRequestTokenCardPaymentState extends MyrequestsState {}

class ErrorRequestTokenCardPaymentState extends MyrequestsState {}

class LoadingReferenceCodePaymentState extends MyrequestsState {}

class SuccessReferenceCodePaymentState extends MyrequestsState {}

class ErrorReferenceCodePaymentState extends MyrequestsState {}

class LoadingSendTransactionState extends MyrequestsState {}

class SuccessSendTransactionState extends MyrequestsState {}

class ErrorSendTransactionState extends MyrequestsState {}
