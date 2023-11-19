// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String url;
  final String message;
  final int? statusCode;
  final Response? response;

  ServerException({
    required this.url,
    required this.message,
    this.statusCode,
    this.response,
  });

  @override
  String toString() {
    return '\nServerException(\n url: $url,\n message: $message,\n statusCode: $statusCode,\n response: $response\n)';
  }
}

class CacheException implements Exception {
  final String objectId;
  final String message;

  CacheException({
    required this.objectId,
    required this.message,
  });
}
