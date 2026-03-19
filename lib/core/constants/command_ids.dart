class CommandIds {
  CommandIds._();

  // CMD bytes (App -> MS200)
  static const int cmdSetClock = 0x07;
  static const int cmdGetSerial = 0x0C;
  static const int cmdSetUserParams = 0x21;
  static const int cmdGetUserParams = 0x22;
  static const int cmdStartSensing = 0x28;
  static const int cmdStopSensing = 0x29;
  static const int cmdSendData = 0x2A;
  static const int cmdSetSystemParams = 0x2D;
  static const int cmdGetSystemParams = 0x2E;

  // ACK bytes (MS200 -> App)
  static const int ackSetClock = 0x47;
  static const int ackGetSerial = 0x4C;
  static const int ackSetUserParams = 0x61;
  static const int ackGetUserParams = 0x62;
  static const int ackStartSensing = 0x68;
  static const int ackStopSensing = 0x69;
  static const int ackSendData = 0x6A;
  static const int ackSetSystemParams = 0x6D;
  static const int ackGetSystemParams = 0x6E;

  // Frame headers
  static const int headerCmd = 0x7E;
  static const int headerAck = 0x7D;

  // Data flags
  static const int flagDetailedData = 0xA6;

  // ACK response codes (Appendix Table 1)
  static const int ackSuccess = 0;
  static const int ackChecksumError = 1;
  static const int ackCommandError = 2;
  static const int ackParamError = 3;
  static const int ackAccessError = 4;
  static const int ackEraseContinue = 16;

  // System states (Appendix Table 2)
  static const int stateIdle = 0;
  static const int stateStandalone = 1;
  static const int stateRealtime = 2;
  static const int stateUploading = 3;
  static const int stateErasing = 4;
  static const int stateAdvertising = 5;
}
