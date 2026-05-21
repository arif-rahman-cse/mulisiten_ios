import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiService {
  final Dio _dio;
  final _log = Logger(printer: SimplePrinter(printTime: false));

  ApiService({required String baseUrl, required String apiKey})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Content-Type': 'application/json',
            if (apiKey.isNotEmpty) 'X-Api-Key': apiKey,
          },
        ),
      );

  void updateConfig({String? baseUrl, String? apiKey}) {
    if (baseUrl != null) _dio.options.baseUrl = baseUrl;
    if (apiKey != null) {
      if (apiKey.isEmpty) {
        _dio.options.headers.remove('X-Api-Key');
      } else {
        _dio.options.headers['X-Api-Key'] = apiKey;
      }
    }
  }

  Future<Response> postSensorData(Map<String, dynamic> body) async {
    try {      
      final res = await _dio.post('sensor-data-raw', data: body);
      return res;
    } catch (e) {
      _log.w('POST sensor-data-raw failed: $e');
      rethrow;
    }
  }

  Future<Response> postSensingBatch(Map<String, dynamic> body) async {
    try {
      final res = await _dio.post('api/v1/sensing-batch', data: body);
      return res;
    } catch (e) {
      _log.w('POST sensing-batch failed: $e');
      rethrow;
    }
  }

  Future<Response> postFallEvent(Map<String, dynamic> body) async {
    try {
      final res = await _dio.post('sensor-data-raw', data: body);
      return res;
    } catch (e) {
      _log.w('POST fall-event failed: $e');
      rethrow;
    }
  }
}
