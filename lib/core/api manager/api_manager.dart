import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'api_constants.dart';

@singleton
class ApiManager {
  final Dio dio = Dio();

  Future<Response> getData({
    required String endPoints,
    Map<String, dynamic>? queryParams,
  }) async {
    return dio.get(
      ApiConstants.baseUrl + endPoints,
      queryParameters: queryParams,
    );
  }

  Future<Response> postData({
    required String baseurl,
    required String endPoints,
    Map<String, dynamic>? queryParams,
    Object? data,
  }) async {
    return dio.post(
      baseurl + endPoints,
      queryParameters: queryParams,
      data: data,
      options: Options(validateStatus: (status) => true),
    );
  }
}
