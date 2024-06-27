// ignore_for_file: must_be_immutable
part of 'registraion_bloc.dart';

abstract class RegistraionEvent extends Equatable {
  const RegistraionEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends RegistraionEvent {
  String email;
  String password;
  SignInEvent(this.email, this.password);
}

class SignUpEvent extends RegistraionEvent {
  String email;
  String password;
  String name;

  SignUpEvent(this.email, this.password, this.name);
}
