part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditEvent extends EditProfileEvent {
  final String name;
  final String phone;
  EditEvent(this.name, this.phone);
}
