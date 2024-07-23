import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/api/api_manager.dart';
import 'package:osama_consul/core/api/end_points.dart';
import 'package:osama_consul/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'myrequests_state.dart';

class MyrequestsCubit extends Cubit<MyrequestsState> {
  MyrequestsCubit() : super(MyrequestsInitial());
  static MyrequestsCubit get(context) => BlocProvider.of(context);
  String authToken = '';
  String orderId = '';
  String requestToken = '';
  String refCode = '';
  void getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    String phone = prefs.getString('phone') ?? '';
    String fName = prefs.getString('name') ?? '';
    String lName = prefs.getString('name') ?? '';
    String amount = '3000';
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
}
