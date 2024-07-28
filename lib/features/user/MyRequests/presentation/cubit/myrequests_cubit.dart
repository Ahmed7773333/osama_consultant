import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/api/api_manager.dart';
import 'package:osama_consul/core/api/end_points.dart';
import 'package:osama_consul/core/utils/constants.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';
import 'package:osama_consul/features/user/MyRequests/domain/usecases/get_all_requests.dart';

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
  int trg = 0;
  List<RequestModel> allRequests = [];
  Future<void> getAllRequests() async {
    emit(LoadingMyRequestsState());
    var result = await getAllRequestsUseCase();
    result.fold((l) {
      emit(ErrorMyRequestState());
    }, (r) {
      allRequests = r;
      emit(SuccessMyRequestState());
    });
  }

  void getAuthToken() async {
    String email = (await UserPreferences.getEmail()) ?? '';
    String phone = (await UserPreferences.getPhone()) ?? '';
    String fName = (await UserPreferences.getName()) ?? '';
    String lName = (await UserPreferences.getName()) ?? '';
    String amount = '3000';
    trg = 0;
    emit(LoadingAuthTokenPaymentState());
    ApiManager().payData(EndPoints.getToken,
        body: {"api_key": Constants.payApiKey}).then((value) {
      authToken = value.data["token"];
      debugPrint("Route token > $authToken");
      getOrderID(email, phone, fName, lName, amount);
      emit(SuccessAuthTokenPaymentState());
    }).catchError((error) {
      debugPrint(error.toString());

      emit(ErrorAuthTokenPaymentState());
    });
  }

  void getOrderID(
      String email, String phone, String fName, String lName, String amount) {
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

      getRequestTokenCard(email, phone, fName, lName, amount);
      emit(SuccessOrderIdPaymentState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ErrorOrderIdPaymentState());
    });
  }

  void getRequestTokenCard(
      String email, String phone, String fName, String lName, String amount) {
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
      emit(SuccessRequestTokenCardPaymentState());
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

  void sendTransaction(Map<String, dynamic> map) {
    emit(LoadingSendTransactionState());
    ApiManager().postDataa("/api/paymob/transaction", body: map).then((value) {
      trg = 1;
      emit(SuccessSendTransactionState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ErrorSendTransactionState());
    });
  }
}
