import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String url;
  final String message;
  final int? statusCode;
  final Response? response;
  final dynamic data;

  ApiException({
    required this.url,
    required this.message,
    this.statusCode,
    this.response,
    this.data,
  });

  /// IMPORTANT NOTE
  /// here you can take advantage of toString() method to display the error for user
  /// lets make an example
  /// so in onError method when you make api you can just user apiExceptionInstance.toString() to get the error message from api
  @override
  toString() {
    // TODO add error message field which is coming from api for you (For ex: response.dat['error']['message']
    String result = '';
    String? responseMsg;
    try {
      responseMsg = response?.data?[
          'message']; // ['message'] base on response error object from server / api
    } catch (_) {}

    result += responseMsg ?? '';

    if (result.isEmpty) {
      result +=
          message; // message is the (dio error message) so usualy its not user friendly
    }

    return result;
  }
}
