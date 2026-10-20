import 'package:dio/dio.dart';
import '../config/env.dart';

class TestClient {
  late final Dio dio;

  TestClient() {
    dio = Dio(BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      validateStatus: (status) => status != null && status < 500,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
  }

  Future<Map<String, dynamic>?> testConnection() async {
    try {
      final response = await dio.get('/test');
      print('--- TEST SUCCESS: ${response.data} ---');
      return response.data as Map<String, dynamic>?;
    } catch (e) {
      print('--- TEST FAILED: $e ---');
      return null;
    }
  }
}
