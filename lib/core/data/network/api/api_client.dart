import 'dart:async';
import 'dart:io';

import 'package:ccp_clean_architecture/core/res/api_res.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../errors/exceptions.dart';

enum CallStatus {
  initial,
  loading,
  success,
  error,
  empty,
  cache,
  refresh,
}

enum RequestType {
  get,
  post,
  put,
  delete,
}

class ApiClient {
  ApiClient._();

  static final Dio _dio = Dio(BaseOptions(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  }))
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ))
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) => handler.next(options),
      onError: (error, handler) => handler.next(error),
      onResponse: (response, handler) => handler.next(response),
    ));

  // request timeout (default 10 seconds)
  static const int _timeoutInSeconds = 10;

  static const Map<String, dynamic> _headersFormat = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    // 'Authorization': 'Bearer ', // Uncomment this and put actual token
  };

  /// Once the api call success it will return [Response]
  /// if the call is failed it will return [ServerException]
  /// to use the condition wether the call is success or failed
  /// do it like this
  /// ```dart
  /// final response = await ApiClient.call('https://api-url-here', RequestType.get);
  /// if(response is ServerException){
  ///  ... do something here
  /// showSnackBar(title: response.message);
  /// }
  /// ```
  static Future call(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Function(int value, int progress)? onReceiveProgress,
    Function(int total, int progress)?
        onSendProgress, // while sending (uploading) progress
    dynamic data,
  }) async {
    if (headers != null) {
      headers.addAll(_headersFormat);
    } else {
      headers = _headersFormat;
    }

    try {
      // Check device internet connection
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        Logger().e('NO INTERNET');
        throw const SocketException('');
      }

      late Response response;

      final Options options = Options(
        headers: headers,
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      );

      if (requestType == RequestType.get) {
        response = await _dio.get(
          url,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParameters,
          options: options,
        );
      } else if (requestType == RequestType.post) {
        response = await _dio.post(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: options,
        );
      } else if (requestType == RequestType.put) {
        response = await _dio.put(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: options,
        );
      } else {
        response = await _dio.delete(
          url,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );
      }

      return response;
    } on DioException catch (error) {
      return ServerException(
        message: error.message ?? 'Something went wrong, please try again.',
        url: url,
        response: error.response,
        statusCode: error.response?.statusCode ?? 500,
      );
      // dio error (api reach the server but not performed successfully
    } catch (error, stackTrace) {
      // print the line of code that throw unexpected exception
      if (kDebugMode) Logger().e('stackTrace: $stackTrace');
      return ServerException(
        message: 'Something went wrong, please try again.',
        url: url,
        statusCode: 500,
      );
    }
  }

  /// Download file
  static download(
      {required String url, // file url
      required String savePath, // where to save file
      required Function(ServerException) onError,
      Function(int value, int progress)? onReceiveProgress,
      required Function onSuccess}) async {
    try {
      await _dio.download(
        url,
        savePath,
        options: Options(
            receiveTimeout: const Duration(seconds: _timeoutInSeconds),
            sendTimeout: const Duration(seconds: _timeoutInSeconds)),
        onReceiveProgress: onReceiveProgress,
      );
      onSuccess();
    } catch (error) {
      var exception = ServerException(
        url: url,
        message: error.toString(),
      );
      return onError(exception);
    }
  }

  static Future testApiClient() async {
    final response = await call(ApiRes.singleUser, RequestType.post);
    final isResponse = response is Response<dynamic>;
    final isServerException = response is ServerException;

    if (response is ServerException) {
      Logger().e(
        '''
Url: ${response.url}
Status Code: ${response.statusCode}
Message: ${response.message}
Response: ${response.response}
    ''',
      );
      return;
    }

    Logger().w(
      '''
runtimeType: ${response.runtimeType}
isResponse: $isResponse
isServerException: $isServerException
response: $response
    ''',
    );
  }
}
