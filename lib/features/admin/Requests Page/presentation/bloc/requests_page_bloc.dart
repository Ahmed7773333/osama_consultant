import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/features/admin/Requests%20Page/domain/usecases/get_all_requests.dart';

import '../../../../user/MyRequests/data/models/all_meeting_response.dart';

part 'requests_page_event.dart';
part 'requests_page_state.dart';

class RequestsPageBloc extends Bloc<RequestsPageEvent, RequestsPageState> {
  static RequestsPageBloc get(context) => BlocProvider.of(context);
  GetAllRequestsAdminUseCase getAllRequestsUseCase;
  List<RequestModel> allRequests = [];

  RequestsPageBloc(this.getAllRequestsUseCase) : super(RequestsPageInitial()) {
    on<RequestsPageEvent>((event, emit) async {
      if (event is GetAllRequestsAdminEvent) {
        emit(LoadingAllRequestsState());
        var result = await getAllRequestsUseCase();
        result.fold((l) {
          emit(ErrorAllRequestState());
        }, (r) {
          allRequests = r;
          emit(SuccessAllRequestState());
        });
      }
    });
  }
}
