import 'dart:typed_data';

class ByteUtils {
  ByteUtils._();

  static int readUint8(Uint8List data, int offset) {
    return data[offset] & 0xFF;
  }

  static int readInt8(Uint8List data, int offset) {
    final v = data[offset] & 0xFF;
    return v > 127 ? v - 256 : v;
  }

  static int readUint16LE(Uint8List data, int offset) {
    return (data[offset] & 0xFF) | ((data[offset + 1] & 0xFF) << 8);
  }

  static int readInt16LE(Uint8List data, int offset) {
    final v = readUint16LE(data, offset);
    return v > 32767 ? v - 65536 : v;
  }

  static int readUint32LE(Uint8List data, int offset) {
    return (data[offset] & 0xFF) |
        ((data[offset + 1] & 0xFF) << 8) |
        ((data[offset + 2] & 0xFF) << 16) |
        ((data[offset + 3] & 0xFF) << 24);
  }

  static int readInt32LE(Uint8List data, int offset) {
    final bytes = ByteData.sublistView(data, offset, offset + 4);
    return bytes.getInt32(0, Endian.little);
  }

  static void writeUint8(Uint8List data, int offset, int value) {
    data[offset] = value & 0xFF;
  }

  static void writeUint16LE(Uint8List data, int offset, int value) {
    data[offset] = value & 0xFF;
    data[offset + 1] = (value >> 8) & 0xFF;
  }

  static void writeInt16LE(Uint8List data, int offset, int value) {
    writeUint16LE(data, offset, value & 0xFFFF);
  }

  static void writeUint32LE(Uint8List data, int offset, int value) {
    data[offset] = value & 0xFF;
    data[offset + 1] = (value >> 8) & 0xFF;
    data[offset + 2] = (value >> 16) & 0xFF;
    data[offset + 3] = (value >> 24) & 0xFF;
  }
}
