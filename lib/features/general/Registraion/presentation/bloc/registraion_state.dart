// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

part of 'registraion_bloc.dart';

abstract class RegistraionState extends Equatable {
  const RegistraionState();

  @override
  List<Object> get props => [];
}

class RegistraionInitial extends RegistraionState {}

class AuthLoading extends RegistraionState {}

class SignUpError extends RegistraionState {
  Failures l;
  SignUpError(this.l);
}

class SigninError extends RegistraionState {
  Failures l;
  SigninError(this.l);
}

class AuthSuccess extends RegistraionState {
  AuthResponseModel user;
  AuthSuccess(
    this.user,
  );
}

class ForgetPassLoading extends RegistraionState {}

class ForgetPassError extends RegistraionState {}

class ForgetPassSuccess extends RegistraionState {}

class ResetPassLoading extends RegistraionState {}

class ResetPassError extends RegistraionState {}

class ResetPassSuccess extends RegistraionState {}
