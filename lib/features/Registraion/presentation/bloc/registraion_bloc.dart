import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'registraion_event.dart';
part 'registraion_state.dart';

class RegistraionBloc extends Bloc<RegistraionEvent, RegistraionState> {
  RegistraionBloc() : super(RegistraionInitial()) {
    on<RegistraionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
