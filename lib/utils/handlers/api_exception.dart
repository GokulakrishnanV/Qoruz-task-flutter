import 'dart:io' show SocketException;

import 'package:dio/dio.dart' show DioException;
import 'package:flutter/material.dart' show BuildContext;
import 'package:qoruz/utils/constants/enums.dart' show Status;
import 'package:qoruz/utils/constants/strings.dart';
import 'package:qoruz/utils/handlers/app_exceptions.dart';
import 'package:qoruz/views/widgets/custom_snackbar.dart' show CustomSnackBar;

class ApiException {
  static AppException handleApiException(DioException e) {
    if (e.error.runtimeType == SocketException) {
      throw DataFetchException(AppStrings.noInternet);
    } else if (e.response?.statusCode == 400) {
      throw BadRequestException(e.message ?? AppStrings.badRequest);
    } else if (e.response?.statusCode == 401) {
      throw UnauthorizedException();
    } else if (e.response?.statusCode == 429) {
      throw TooManyRequestsException();
    } else if (e.response?.statusCode == 500) {
      throw InternalErrorException();
    } else {
      throw UnknownErrorException();
    }
  }

  static void handleUiException(
    BuildContext context, {
    required Status status,
    String? message,
    bool? showDataNotFound,
    void Function()? onServerError,
  }) {
    if (status == Status.error) {
      onServerError?.call();
      if (message == AppStrings.noInternet) {
        //TODO: Design No internet page

        // context.goNamed(noInternetRoute);
        CustomSnackBar.show(context, title: message ?? AppStrings.noInternet);
      } else if (showDataNotFound ?? true) {
        CustomSnackBar.show(context, title: message ?? AppStrings.unknownError);
      }
    }
  }
}
