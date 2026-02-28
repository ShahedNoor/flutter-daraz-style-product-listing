import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common_widgets/custom_toast_message.dart';
import '../../../../../../networks/rx_base.dart';
import 'api.dart';

final class PostSignUpRx extends RxResponseInt {
  final api = PostSignUpApi.instance;

  String message = "Something went wrong";

  PostSignUpRx({required super.empty, required super.dataFetcher});

  ValueStream get fileData => dataFetcher.stream;

  Future<bool> postSignUp({
    String? email,
    String? username,
    String? password,
  }) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        "username": username,
        "password": password,
        "name": {"firstname": "John", "lastname": "Doe"},
        "address": {
          "city": "kilcoole",
          "street": "7835 new road",
          "number": 3,
          "zipcode": "12926-3874",
          "geolocation": {"lat": "-37.3159", "long": "81.1496"}
        },
        "phone": "1-570-236-7033"
      };

      Map resdata = await api.postSignUp(data);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    customToastMessage('Success', 'User created successfully');
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
