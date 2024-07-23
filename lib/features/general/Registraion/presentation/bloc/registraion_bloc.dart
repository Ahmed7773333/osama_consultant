import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/features/general/Registraion/domain/usecases/sign_in_google_usercase.dart';

import '../../../../../core/eror/failuers.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
part 'registraion_event.dart';
part 'registraion_state.dart';

class RegistraionBloc extends Bloc<RegistraionEvent, RegistraionState> {
  static RegistraionBloc get(context) => BlocProvider.of(context);
  SignInUseCase signInUseCase;
  SignUpUseCase signUpUseCase;
  SignInGoogleUseCase signInGoogleUseCase;
  RegistraionBloc(
      this.signInUseCase, this.signUpUseCase, this.signInGoogleUseCase)
      : super(RegistraionInitial()) {
    on<RegistraionEvent>((event, emit) async {
      if (event is SignInEvent) {
        emit(AuthLoading());
        var result = await signInUseCase(event.email, event.password);
        result.fold((l) {
          emit(AuthError(l));
        }, (r) {
          emit(AuthSuccess(r));
        });
      } else if (event is SignUpEvent) {
        emit(AuthLoading());
        var result = await signUpUseCase(event.email, event.password,
            event.name, event.repassword, event.phone);
        result.fold((l) {
          emit(AuthError(l));
        }, (r) {
          emit(AuthSuccess(r));
        });
      } else if (event is SignInGoogleEvent) {
        emit(AuthLoading());
        var result = await signInGoogleUseCase();
        result.fold((l) {
          emit(AuthError(l));
        }, (r) {
          emit(AuthSuccess(r));
        });
      }
    });
  }
}
