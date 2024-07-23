import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'requests_page_event.dart';
part 'requests_page_state.dart';

class RequestsPageBloc extends Bloc<RequestsPageEvent, RequestsPageState> {
  RequestsPageBloc() : super(RequestsPageInitial()) {
    on<RequestsPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
