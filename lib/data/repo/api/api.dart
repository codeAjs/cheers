import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  final Dio _dio = Dio();

  Dio get sendRequest => _dio;

  API() {
    _dio.options.baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';
    _dio.interceptors.add(PrettyDioLogger());
  }
}