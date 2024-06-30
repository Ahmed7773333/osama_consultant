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

class AuthError extends RegistraionState {
  Failures l;
  AuthError(this.l);
}

class AuthSuccess extends RegistraionState {
  UserModel user;
  AuthSuccess(
    this.user,
  );
}
