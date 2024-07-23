// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class SignInGoogleEvent extends RegistraionEvent {}

class SignUpEvent extends RegistraionEvent {
  String email;
  String password;
  String name;
  String repassword;
  String phone;

  SignUpEvent(
    this.email,
    this.password,
    this.name,
    this.phone,
    this.repassword,
  );
}
