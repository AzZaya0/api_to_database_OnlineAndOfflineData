import 'package:dio/dio.dart';

class Api {
  Dio _dio = Dio();
  Api() {
    _dio.options.baseUrl = 'https://fakestoreapi.com';
  }
  Dio get sentrequest => _dio;
}
