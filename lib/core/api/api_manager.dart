import 'package:dio/dio.dart';

import '../utils/constants.dart';

class ApiManager {
  Dio dio = Dio();
  Future<Response> getData(String endPoint, {Map<String, dynamic>? data}) {
    return dio.get(Constants.basURl + endPoint, queryParameters: data);
  }

  Future<Response> getDataa(String endPoint, {Map<String, dynamic>? data}) {
    final options = Options(headers: data);
    return dio.get(Constants.basURl + endPoint, options: options);
  }

  Future<Response> postData(String endPoint, {Map<String, dynamic>? body}) {
    return dio.post(Constants.basURl + endPoint,
        data: body, options: Options(contentType: "application/json"));
  }

  Future<Response> postDataa(String endPoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? data}) {
    final options = Options(headers: data);

    return dio.post(Constants.basURl + endPoint, data: body, options: options);
  }

  Future<Response> putData(String endPoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? data}) {
    final options = Options(headers: data);

    return dio.put(Constants.basURl + endPoint, data: body, options: options);
  }

  Future<Response> payData(String endPoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? data}) {
    final options = Options(headers: data);

    return dio.post(Constants.payUrl + endPoint, data: body, options: options);
  }

  Future<Response> deleteData(String endPoint, {Map<String, dynamic>? data}) {
    final options = Options(headers: data);

    return dio.delete(Constants.basURl + endPoint, options: options);
  }
}
