import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/api/api_manager.dart';
import 'package:osama_consul/core/api/end_points.dart';
import 'package:osama_consul/core/utils/constants.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/store_consultant.dart';
import 'package:osama_consul/features/user/MyRequests/domain/usecases/get_all_requests.dart';

import '../../../../../core/cache/notification_service.dart';
import '../../../../../core/cache/shared_prefrence.dart';

part 'myrequests_state.dart';

class MyrequestsCubit extends Cubit<MyrequestsState> {
  MyrequestsCubit(this.getAllRequestsUseCase) : super(MyrequestsInitial());
  static MyrequestsCubit get(context) => BlocProvider.of(context);
  GetAllRequestsUseCase getAllRequestsUseCase;
  String authToken = '';
  String orderId = '';
  String requestToken = '';
  String refCode = '';
  String rtcToken = '';
  int trg = 0;
  List<RequestModel> allRequests = [];
  RequestModel? userRequest;
  Future<void> getAllRequests() async {
    emit(LoadingMyRequestsState());
    var result = await getAllRequestsUseCase();
    result.fold((l) {
      debugPrint(l.message);
      emit(ErrorMyRequestState());
    }, (r) {
      allRequests = r;
      emit(SuccessMyRequestState());
    });
  }

  void setRequest(RequestModel request) {
    emit(LoadingSetRequestState());
    userRequest = request;
    emit(SuccessSetRequestState());
  }

  void getAuthToken() async {
    String email = (await UserPreferences.getEmail()) ?? '';
    String phone = ((await UserPreferences.getPhone()) ?? '').isEmpty
        ? '+201000000000'
        : ((await UserPreferences.getPhone()) ?? '');
    String fName = (await UserPreferences.getName()) ?? '';
    String lName = (await UserPreferences.getName()) ?? '';
    String amount = '3000';
    trg = 0;
    emit(LoadingAuthTokenPaymentState());
    ApiManager().payData(EndPoints.getToken,
        body: {"api_key": Constants.payApiKey}).then((value) {
      authToken = value.data["token"];
      debugPrint("Route token > $authToken");
      debugPrint(phone);

      getOrderID(email, phone, fName, lName, amount, userRequest?.id ?? 123);
      emit(SuccessAuthTokenPaymentState());
    }).catchError((error) {
      debugPrint(error.toString());

      emit(ErrorAuthTokenPaymentState());
    });
  }

  void getOrderID(String email, String phone, String fName, String lName,
      String amount, int id) {
    emit(LoadingOrderIdPaymentState());
    ApiManager().payData(EndPoints.getOrderId, body: {
      "auth_token": authToken,
      "delivery_needed": "false",
      "amount_cents": amount,
      "currency": "EGP",
      "items": []
    }).then((value) {
      orderId = value.data["id"].toString();
      debugPrint("Route orderId > $orderId");

      getRequestTokenCard(email, phone, fName, lName, amount, id);
      emit(SuccessOrderIdPaymentState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ErrorOrderIdPaymentState());
    });
  }

  void getRequestTokenCard(String email, String phone, String fName,
      String lName, String amount, int id) {
    emit(LoadingRequestTokenCardPaymentState());
    ApiManager().payData("/acceptance/payment_keys", body: {
      "auth_token": authToken,
      "amount_cents": amount,
      "expiration": 3600,
      "order_id": orderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": fName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "EG",
        "last_name": lName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": Constants.integrationId
    }).then((value) {
      requestToken = value.data["token"];
      emit(SuccessRequestTokenCardPaymentState(id));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ErrorRequestTokenCardPaymentState());
    });
  }

  void getRefCode() {
    emit(LoadingReferenceCodePaymentState());
    ApiManager().payData("/acceptance/payments/pay", body: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": requestToken
    }).then((value) {
      refCode = value.data["id"].toString();

      emit(SuccessReferenceCodePaymentState());
    }).catchError((error) {
      emit(ErrorReferenceCodePaymentState());
    });
  }

  void sendMeetingTransaction(Map<String, dynamic> map) {
    emit(LoadingSendTransactionState());
    ApiManager().postDataa("/api/paymob/transaction", body: map).then((value) {
      trg = 1;
      debugPrint((userRequest!.id == map['meeting_id']).toString());
      getAllRequests();
      setRequest(allRequests.firstWhere((test) {
        return userRequest!.id == test.id;
      }));
      NotificationService().pushNotification('For Request ${userRequest!.id}',
          'The payment was done', 'admin@chat.com');
      emit(SuccessSendTransactionState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ErrorSendTransactionState());
    });
  }

  Future<void> storeConusltant(int id) async {
    emit(LoadingStoreConusltantState());
    ApiManager().postDataa(
      EndPoints.consultantPlus,
      body: {"user_id": (await UserPreferences.getId()), "transaction_id": id},
      data: {
        'Authorization': 'Bearer ${(await UserPreferences.getToken()) ?? ''}'
      },
    ).then((value) {
      trg = 1;

      int count =
          StoreConsultantModel.fromJson(value.data).data?.consultantsCount ?? 0;
      debugPrint('counter:>>>>>>' + count.toString());
      UserPreferences.setConsultantCount(count);
      emit(SuccessStoreConusltantState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ErrorStoreConusltantState());
    });
  }
}
