import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class PostLoginApi {
  static final PostLoginApi _singleton = PostLoginApi._internal();
  PostLoginApi._internal();
  static PostLoginApi get instance => _singleton;

  Future<Map> postLogin(Map data) async {
    try {
      Response response = await postHttp(Endpoints.login(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
