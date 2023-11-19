import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_exceptions.dart';

enum RequestType {
  get,
  post,
  put,
  delete,
}

class ApiClient {
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

  /// dio getter (used for testing)
  static get dio => _dio;

  /// perform safe api request
  static call(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    required Function(ApiException error) onError,
    Function(int value, int progress)? onReceiveProgress,
    Function(int total, int progress)?
        onSendProgress, // while sending (uploading) progress
    Function? onLoading,
    dynamic data,
    bool isOverwriteException = false,
  }) async {
    try {
      Map<String, dynamic> headersFormat = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        // 'Authorization': 'Bearer *put user token here example: Get.find<AuthController>().user.token',
      };
      if (headers != null) {
        headers.addAll(headersFormat);
      } else {
        headers = headersFormat;
      }
    } catch (_) {}

    try {
      // 1) indicate loading state
      await onLoading?.call();

      // Check device internet connection
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        Logger().e('NO INTERNET');
        throw const SocketException('');
      }

      // 2) try to perform http request
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
      // 3) return response (api done successfully)
      await onSuccess(response);
    } on DioException catch (error) {
      // dio error (api reach the server but not performed successfully
      _handleDioError(
        error: error,
        url: url,
        onError: onError,
      );
    } on SocketException {
      // No internet connection
      _handleSocketException(url: url, onError: onError);
    } on TimeoutException {
      // Api call went out of time
      _handleTimeoutException(url: url, onError: onError);
    } catch (error, stackTrace) {
      // print the line of code that throw unexpected exception
      Logger().e(stackTrace);
      // unexpected error for example (parsing json error)
      _handleUnexpectedException(url: url, onError: onError, error: error);
    }
  }

  /// download file
  static download(
      {required String url, // file url
      required String savePath, // where to save file
      required Function(ApiException) onError,
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
      var exception = ApiException(
        url: url,
        message: error.toString(),
      );
      return onError(exception);
    }
  }

  /// handle Dio error
  static _handleDioError({
    required DioException error,
    required Function(ApiException) onError,
    required String url,
  }) {
    var exception = ApiException(
      url: url,
      message: error.message ?? 'Something Went Error!',
      statusCode: error.response?.statusCode,
      response: error.response,
      data: error.response?.data,
    );

    return onError(exception);
  }

  /// handle unexpected error
  static _handleUnexpectedException(
      {required Function(ApiException) onError,
      required String url,
      required Object error}) {
    var exception = ApiException(
      message: 'Something went wrong',
      url: url,
    );
    onError(exception);
  }

  /// handle timeout exception
  static _handleTimeoutException(
      {required Function(ApiException) onError, required String url}) {
    var exception = ApiException(
      message: 'Server is not responding',
      url: url,
      statusCode: 408,
    );
    return onError(exception);
  }

  /// handle socket exception
  static _handleSocketException(
      {required Function(ApiException) onError, required String url}) {
    var exception = ApiException(
      message: 'No internet connection',
      url: url,
    );
    return onError(exception);
  }
}
