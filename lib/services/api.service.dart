import 'package:dio/dio.dart';

// ANCHOR Api Service
class ApiService {
  late Dio dio;

  // ANCHOR Constructor
  ApiService() {
    _init();
  }

  // ANCHOR Init
  void _init() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://172.20.10.3:5100/',
      // baseUrl: 'http://localhost:5100/',
      connectTimeout: const Duration(
        minutes: 5,
      ),
      sendTimeout: const Duration(
        minutes: 5,
      ),
      receiveTimeout: const Duration(
        minutes: 5,
      ),
    );

    dio = Dio(options);
  }
}
