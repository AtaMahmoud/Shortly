import 'dart:io';

import 'package:dio/dio.dart';

import 'package:shorty/src/business_logic/models/failure.dart';
import 'package:shorty/src/business_logic/models/shorten_url.dart';
import 'package:shorty/src/services/web_api/web_api.dart';

class WebApiImplementaion implements WebApi {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https://api.shrtco.de/v2",
      contentType: Headers.jsonContentType));

  @override
  Future<ShortenUrl> shortUrl(String url) async {
    try {
      final response =
          await _dio.post("/shorten", queryParameters: {'url': url});
      return ShortenUrl.fromJson(response.data['result']);
    
    // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      throw getCurrentFailure(e);
    }
  }
}

Failure getCurrentFailure(error) {
  try {
    Failure failure;
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          failure = Failure(error: error, errorMessage: "Request Cancelled");
          break;
        case DioErrorType.connectTimeout:
          failure =
              Failure(error: error, errorMessage: "Connection request timeout");
          break;
        case DioErrorType.other:
          failure =
              Failure(error: error, errorMessage: "No internet connection!");
          break;
        case DioErrorType.receiveTimeout:
          failure = Failure(
              error: error,
              errorMessage: "Send timeout in connection with API server");
          break;
        case DioErrorType.sendTimeout:
          failure = Failure(
              error: error,
              errorMessage: "Send timeout in connection with API server");
          break;
        case DioErrorType.response:
          final int errorCode = error.response!.data['error_code'];
          failure =
              Failure(errorMessage: _getErrorMessage(errorCode), error: error);
      }
    } else if (error is SocketException) {
      failure = Failure(error: error, errorMessage: "No internet connection!");
    } else if (error.toString().contains("is not a subtype of")) {
      failure = _unableToProcessDataFailure(error);
    } else if (error is FormatException) {
      failure = _formateExceptionFailure(error);
    } else {
      failure = _unexpectedErrorFailure(error);
    }

    return failure;
  } on FormatException catch (e) {
    return _formateExceptionFailure(e);
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    return _unexpectedErrorFailure(error);
  }
}

Failure _unableToProcessDataFailure(Exception error) =>
    Failure(error: error, errorMessage: "Unable to process the data");

Failure _unexpectedErrorFailure(error) =>
    Failure(error: error, errorMessage: "Unexpected error occurred!");

Failure _formateExceptionFailure(FormatException error) {
  return Failure(
      error: error,
      errorMessage:
          "Data does not have an expected format and cannot be parsed or processed");
}

String? _getErrorMessage(int errorCode) {
  final errorCodeMessages = <int, String>{
    1: "No URL specified",
    2: "Invalid URL submitted",
    3: "Rate limit reached. Wait a second and try again",
    4: "IP-Address has been blocked because of violating terms of service",
    5: "shrtcode code (slug) already taken/in use",
    6: "Unknown error",
    7: "No code specified",
    8: "Invalid code submitted (code not found/there is no such short-link)",
    9: "Missing required parameters",
    10: "Trying to shorten a disallowed Link"
  };
  if (errorCodeMessages.containsKey(errorCode)) {
    return errorCodeMessages[errorCode];
  }

  return "Unknown error";
}
