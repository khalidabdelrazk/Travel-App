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
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return dio.post(
      path,
      options: options,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress
    );
  }
}
