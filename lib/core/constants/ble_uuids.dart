import 'dart:typed_data';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleUuids {
  BleUuids._();

  static final nusService = Guid('6e400001-b5a3-f393-e0a9-e50e24dcca9e');
  static final nusRx = Guid('6e400002-b5a3-f393-e0a9-e50e24dcca9e');
  static final nusTx = Guid('6e400003-b5a3-f393-e0a9-e50e24dcca9e');
  static final cccd = Guid('00002902-0000-1000-8000-00805f9b34fb');

  static const deviceNamePrefix = 'MSB';

  /// "MSBandPC" magic string required for read commands.
  static final magic = Uint8List.fromList(
    [0x4D, 0x53, 0x42, 0x61, 0x6E, 0x64, 0x50, 0x43],
  );
}
