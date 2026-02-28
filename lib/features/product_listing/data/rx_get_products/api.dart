import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class GetProductsApi {
  static final GetProductsApi _singleton = GetProductsApi._internal();
  GetProductsApi._internal();
  static GetProductsApi get instance => _singleton;

  Future<List> getProducts() async {
    try {
      Response response = await getHttp(
        Endpoints.products(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
