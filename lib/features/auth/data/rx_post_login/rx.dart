import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_daraz_style_product_listing/constants/app_constants.dart';
import 'package:flutter_daraz_style_product_listing/helpers/di.dart';
import 'package:flutter_daraz_style_product_listing/helpers/post_login.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common_widgets/custom_toast_message.dart';
import '../../../../../../networks/rx_base.dart';
import 'api.dart';

final class PostLoginRx extends RxResponseInt {
  final api = PostLoginApi.instance;

  String message = "Something went wrong";

  PostLoginRx({required super.empty, required super.dataFetcher});

  ValueStream get fileData => dataFetcher.stream;

  Future<bool> postLogin({
    String? username,
    String? password,
  }) async {
    try {
      Map<String, dynamic> data = {
        "username": username,
        "password": password,
      };

      Map resdata = await api.postLogin(data);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    appData.write(kKeyAccessToken, data['token']);
    appData.write(kKeyIsLoggedIn, true);
    performPostLoginActions();
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      if (error.response?.data != null) {
        if (error.response?.data is Map &&
            error.response!.data["message"] != null) {
          message = error.response!.data["message"].toString();
        } else if (error.response?.data is String) {
          message = error.response!.data.toString();
        }
      }
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
