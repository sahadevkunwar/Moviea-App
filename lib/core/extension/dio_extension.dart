import 'dart:io';

import 'package:bloc_project/core/exception/api_exception.dart';
import 'package:dio/dio.dart';

extension DioErrorX on DioException {
  ApiException get toApiException {
    switch (type) {
      case DioExceptionType.badResponse:
        final statusCode = response?.statusCode;
        if (statusCode == 200) {
          final error = response?.data as Map<String, dynamic>;
          return ApiException.errorFromBacked(message: error.toString());
        }
        return ApiException.serverException(
            message:
                'we are unable to process your request. Please try again later.');

      case DioExceptionType.connectionTimeout:
        break;
      case DioExceptionType.sendTimeout:
        break;
      case DioExceptionType.receiveTimeout:
        break;
      case DioExceptionType.badCertificate:
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        return ApiException.networkError();

      case DioExceptionType.unknown:
        break;
    }
    return ApiException.networkError();
  }

  bool get noConnectionError =>
      type == DioExceptionType.connectionError && error is SocketException;

  bool get isUnauthorizedAccess =>
      type == DioExceptionType.badResponse && response?.statusCode == 401;

  String get serverErrorMessage => 'Server Error';
  String get unAuthorizedMessage => 'Unauthorized Error';
}

extension StringX on String {
  int get parseToInt => int.parse(this);
}
