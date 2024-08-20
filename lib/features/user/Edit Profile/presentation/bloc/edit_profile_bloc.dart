import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/features/user/Edit%20Profile/domain/usecases/edit_usecase.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  static EditProfileBloc get(context) => BlocProvider.of(context);
  EditUsecase editUsecase;
  EditProfileBloc(this.editUsecase) : super(EditProfileInitial()) {
    on<EditProfileEvent>((event, emit) async {
      if (event is EditEvent) {
        emit(EditLoading());
        try {
          await editUsecase(event.name, event.phone);
          emit(EditSuccess(event.name, event.phone));
        } catch (e) {
          emit(EditError());
        }
      }
    });
  }
}
