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
            if (apiKey.isNotEmpty) 'Authorization': 'Bearer $apiKey',
          },
        ),
      );

  void updateConfig({String? baseUrl, String? apiKey}) {
    if (baseUrl != null) _dio.options.baseUrl = baseUrl;
    if (apiKey != null) {
      _dio.options.headers['Authorization'] = 'Bearer $apiKey';
    }
  }

  Future<Response> postSensorData(Map<String, dynamic> body) async {
    try {
      _log.d('POST sensor_data_raw: $body');
      return await _dio.post('rawdata/sensor_data_raw', data: body);
    } catch (e) {
      _log.w('POST sensor_data_raw failed: $e');
      rethrow;
    }
  }

  Future<Response> postSensingBatch(Map<String, dynamic> body) async {
    try {
      return await _dio.post('api/v1/sensing-batch', data: body);
    } catch (e) {
      _log.w('POST sensing-batch failed: $e');
      rethrow;
    }
  }

  Future<Response> postFallEvent(Map<String, dynamic> body) async {
    try {
      print("POST fall event: $body");
      return await _dio.post('rawdata/sensor_data_raw', data: body);
    } catch (e) {
      _log.w('POST fall event failed: $e');
      rethrow;
    }
  }
}
