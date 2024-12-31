import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/api/api_manager.dart';
import 'package:osama_consul/core/api/end_points.dart';
import 'package:osama_consul/core/utils/constants.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/store_consultant.dart';
import 'package:osama_consul/features/user/MyRequests/domain/usecases/get_all_requests.dart';
import 'package:uuid/uuid.dart';
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

  // void getAuthToken(bool isWallet) async {
  //   String email = (await UserPreferences.getEmail()) ?? '';
  //   String phone = ((await UserPreferences.getPhone()) ?? '').isEmpty
  //       ? '+201000000000'
  //       : ((await UserPreferences.getPhone()) ?? '');
  //   String fName = (await UserPreferences.getName()) ?? '';
  //   String lName = (await UserPreferences.getName()) ?? '';
  //   String amount = '3000';
  //   trg = 0;
  //   emit(LoadingAuthTokenPaymentState());
  //   ApiManager().payData(EndPoints.getToken,
  //       body: {"api_key": Constants.payApiKey}).then((value) {
  //     authToken = value.data["token"];
  //     debugPrint("Route token > $authToken");
  //     debugPrint(phone);

  //     getOrderID(email, phone, fName, lName, amount, 123, isWallet);
  //     emit(SuccessAuthTokenPaymentState());
  //   }).catchError((error) {
  //     debugPrint(error.toString());

  //     emit(ErrorAuthTokenPaymentState());
  //   });
  // }

  // void getOrderID(String email, String phone, String fName, String lName,
  //     String amount, int id, bool isWallet) {
  //   emit(LoadingOrderIdPaymentState());
  //   ApiManager().payData(EndPoints.getOrderId, body: {
  //     "auth_token": authToken,
  //     "delivery_needed": "false",
  //     "amount_cents": amount,
  //     "currency": "EGP",
  //     "payment_methods": [
  //       123,
  //       isWallet ? "Mobile Wallets" : "Online card Payment inegration Id"
  //     ],
  //     "items": []
  //   }).then((value) {
  //     orderId = value.data["id"].toString();
  //     debugPrint("Route orderId > $orderId");

  //     isWallet
  //         ? getMobileWalletToken()
  //         : getRequestTokenCard(email, phone, fName, lName, amount, id);
  //     emit(SuccessOrderIdPaymentState());
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //     emit(ErrorOrderIdPaymentState());
  //   });
  // }

  // void getRequestTokenCard(String email, String phone, String fName,
  //     String lName, String amount, int id) {
  //   emit(LoadingRequestTokenCardPaymentState());
  //   ApiManager().payData("/acceptance/payment_keys", body: {
  //     "auth_token": authToken,
  //     "amount_cents": amount,
  //     "expiration": 3600,
  //     "order_id": orderId,
  //     "billing_data": {
  //       "apartment": "NA",
  //       "email": email,
  //       "floor": "NA",
  //       "first_name": fName,
  //       "street": "NA",
  //       "building": "NA",
  //       "phone_number": phone,
  //       "shipping_method": "NA",
  //       "postal_code": "NA",
  //       "city": "NA",
  //       "country": "EG",
  //       "last_name": lName,
  //       "state": "NA"
  //     },
  //     "currency": "EGP",
  //     "integration_id": Constants.integrationIdVisa
  //   }).then((value) {
  //     requestToken = value.data["token"];
  //     emit(SuccessRequestTokenCardPaymentState(id));
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //     emit(ErrorRequestTokenCardPaymentState());
  //   });
  // }

  // void getRefCode() {
  //   emit(LoadingReferenceCodePaymentState());
  //   ApiManager().payData("/acceptance/payments/pay", body: {
  //     "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
  //     "payment_token": requestToken
  //   }).then((value) {
  //     refCode = value.data["id"].toString();

  //     emit(SuccessReferenceCodePaymentState());
  //   }).catchError((error) {
  //     emit(ErrorReferenceCodePaymentState());
  //   });
  // }

  Future<void> storeConusltant(int id, bool isTicket) async {
    emit(LoadingStoreConusltantState());
    final int userId = (await UserPreferences.getId() ?? 0);
    await ApiManager().postDataa(
      EndPoints.consultantPlus,
      body: {"user_id": userId, "transaction_id": id, "isTicket": isTicket},
      data: {
        'Authorization': 'Bearer ${(await UserPreferences.getToken()) ?? ''}'
      },
    ).then((value) async {
      trg = 1;

      if (isTicket) {
        int count =
            StoreConsultantModel.fromJson(value.data).data?.consultantsCount ??
                0;
        debugPrint('counter:>>>>>>' + count.toString());
        await UserPreferences.setConsultantCount(count);
      } else {
        if (value.data['success'] == true) {
          await UserPreferences.setSub('1');
        }
      }
      emit(SuccessStoreConusltantState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ErrorStoreConusltantState());
    });
  }

  Future<void> getMobileWalletToken(bool isTicket) async {
    //String email, String phone, String fName,
    //   String lName, String amount, int id
    emit(LoadingMobileWalletTokenState());
    trg = 0;
    final int userId = (await UserPreferences.getId() ?? 0);
    final String email = (await UserPreferences.getEmail()) ?? '';
    final String phone = (await UserPreferences.getPhone()) ?? '';
    final String fName = (await UserPreferences.getName()) ?? '';
    await ApiManager().payData("/v1/intention/", data: {
      'Authorization': Constants.secretKeyLive,
    }, body: {
      "amount": isTicket ? 150000 : 5000,
      "currency": "EGP",
      "payment_methods": [
        Constants.mobileWalletIntegrationIdLive,
        Constants.integrationIdVisaLive
      ],
      "items": [
        {
          "name": "Item name",
          "amount": isTicket ? 150000 : 5000,
          "description": "$userId",
          "quantity": 1
        }
      ],
      "billing_data": {
        "apartment": "dumy",
        "first_name": fName,
        "last_name": "dumy name",
        "street": "dumy",
        "building": "dumy",
        "phone_number": phone,
        "city": "dumy",
        "country": "dumy",
        "email": email,
        "floor": "dumy",
        "state": "dumy"
      },
      "customer": {
        "first_name": fName,
        "last_name": "dumy name",
        "email": email,
        "extras": {"re": "22"},
      },
      "extras": {"ee": 22},
      "special_reference": Uuid().v4(),
      "notification_url": "${Constants.basURl}/api/paymob/callback",
    }).then((value) {
      requestToken = value.data["client_secret"];
      emit(SuccessMobileWalletTokenState(0));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ErrorMobileWalletTokenState());
    });
  }
}
/**
 * 
 * curl --location 'https://accept.paymob.com/v1/intention' \
--header 'Authorization: Token sk_test_626xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' \
--header 'Content-Type: application/json' \
--data-raw '
'
 */
