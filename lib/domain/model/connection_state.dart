enum BleConnectionState {
  disconnected,
  scanning,
  connecting,
  connected;

  bool get isConnected => this == BleConnectionState.connected;
  bool get isDisconnected => this == BleConnectionState.disconnected;
}
