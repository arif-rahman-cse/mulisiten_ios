import 'package:logger/logger.dart';
import 'package:ms200_companion/data/remote/api_service.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:ms200_companion/domain/model/fall_event.dart';

class CloudUploader {
  final ApiService _api;
  final _log = Logger(printer: SimplePrinter(printTime: false));

  CloudUploader(this._api);

  Future<bool> uploadSingleSensingData(
    SensingData data,
    String userName,
  ) async {
    print('uploadSingleSensingData: $data');
    final body = _buildSensorBody(data, userName);
    return _retryPost(() => _api.postSensorData(body));
  }

  Future<bool> uploadFallEvent(FallEvent event) async {
    print('uploadFallEvent: $event');
    final body = {
      'sensor_value': {
        'device_serial': event.deviceId,
        'timestamp': event.timestamp,
        'heart_rate': event.heartRate,
        'situation_index': event.statusIndex,
        'situation_index_level': event.statusLevel,
        'heat_index': event.heatIndex,
        'temperature': event.temperature / 100.0,
        'humidity': event.humidity / 100.0,
        'heat_index_max': event.heatIndexMax,
        'battery_level': event.batteryLevel,
        'latitude': event.latitude / 1e7,
        'longitude': event.longitude / 1e7,
        'altitude_difference': event.altitudeDiff / 10.0,
        'ppi_0': event.ppi0,
        'ppi_1': event.ppi1,
        'ppi_2': event.ppi2,
        'fall_detection_status': event.fallState,
        'user_name': event.userName,
        'blood_index': 0,
        'bma': 0,
        'elapsed_seconds': event.elapsedSeconds,
        'source': event.source,
      },
    };
    return _retryPost(() => _api.postFallEvent(body));
  }

  Future<bool> uploadBatch(List<SensingData> records, String userName) async {
    final items = records.map((d) => _buildSensorValue(d, userName)).toList();
    final body = {'records': items};
    return _retryPost(() => _api.postSensingBatch(body));
  }

  Map<String, dynamic> _buildSensorBody(SensingData data, String userName) {
    return {'sensor_value': _buildSensorValue(data, userName)};
  }

  Map<String, dynamic> _buildSensorValue(SensingData data, String userName) {
    return {
      'device_serial': data.deviceId,
      'timestamp': data.timestamp,
      'heart_rate': data.heartRate,
      'situation_index': data.statusIndex,
      'situation_index_level': data.statusLevel,
      'heat_index': data.heatIndex,
      'temperature': data.temperature / 100.0,
      'humidity': data.humidity / 100.0,
      'heat_index_max': data.heatIndexMax,
      'battery_level': data.batteryLevel,
      'latitude': data.latitude / 1e7,
      'longitude': data.longitude / 1e7,
      'altitude_difference': data.altitudeDiff / 10.0,
      'ppi_0': data.ppi0,
      'ppi_1': data.ppi1,
      'ppi_2': data.ppi2,
      'fall_detection_status': data.fallState,
      'user_name': userName,
      'blood_index': 0,
      'bma': 0,
    };
  }

  Future<bool> _retryPost(
    Future Function() action, {
    int maxRetries = 3,
  }) async {
    for (var i = 0; i < maxRetries; i++) {
      try {
        await action();
        return true;
      } catch (e) {
        _log.w('Upload attempt ${i + 1}/$maxRetries failed: $e');
        if (i < maxRetries - 1) {
          await Future.delayed(Duration(seconds: (1 << i) * 2));
        }
      }
    }
    return false;
  }
}
