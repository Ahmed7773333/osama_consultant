import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/features/admin/Requests%20Page/domain/usecases/accet_request_usecase.dart';
import 'package:osama_consul/features/admin/Requests%20Page/domain/usecases/generate_rtc_token.dart';
import 'package:osama_consul/features/admin/Requests%20Page/domain/usecases/get_all_requests.dart';

import '../../../../user/MyRequests/data/models/all_meeting_response.dart';
import '../../domain/usecases/reject_request_usecase.dart';

part 'requests_page_event.dart';
part 'requests_page_state.dart';

class RequestsPageBloc extends Bloc<RequestsPageEvent, RequestsPageState> {
  static RequestsPageBloc get(context) => BlocProvider.of(context);
  GetAllRequestsAdminUseCase getAllRequestsUseCase;
  RejectRequestUsecase rejectRequestUsecase;
  AccetRequestUsecase accetRequestUsecase;
  GenerateRtcToken generateRtcToken;
  List<RequestModel> allRequests = [];
  RequestModel? userRequest;

  RequestsPageBloc(this.getAllRequestsUseCase, this.rejectRequestUsecase,
      this.accetRequestUsecase, this.generateRtcToken)
      : super(RequestsPageInitial()) {
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
      } else if (event is RejecetRequestEvent) {
        try {
          emit(LoadingOrderState());
          await rejectRequestUsecase(event.id);
          emit(RejectOrderState());
        } catch (e) {
          emit(ErrorOrderState());
        }
      } else if (event is AcceptRequestEvent) {
        try {
          emit(LoadingOrderState());
          await accetRequestUsecase(event.id);
          add(GetAllRequestsAdminEvent());
          emit(AcceptOrderState());
        } catch (e) {
          emit(ErrorOrderState());
        }
      } else if (event is SetRequestAdminEvent) {
        emit(LoadingSetRequestState());
        userRequest = event.request;
        emit(SetRequestAdminSuccessState());
      } else if (event is GenerateRTCTokenAdminEvent) {
        emit(LoadingGenerateRtcTokenState());
        try {
          await generateRtcToken(userRequest!);
          add(GetAllRequestsAdminEvent());
          add(SetRequestAdminEvent(allRequests.firstWhere((test) {
            return userRequest!.id == test.id;
          })));
          emit(SuccessGenerateRtcTokenState());
        } catch (e) {
          emit(ErrorGenerateRtcTokenState());
        }
      }
    });
  }
}
