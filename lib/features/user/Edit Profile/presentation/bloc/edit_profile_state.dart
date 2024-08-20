part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditLoading extends EditProfileState {}

class EditSuccess extends EditProfileState {
  final String name;
  final String phone;
  EditSuccess(this.name, this.phone);
}

class EditError extends EditProfileState {}
