# MS200 Companion App

A cross-platform Flutter companion app for the **Toshiba MULiSiTEN MS200 Multi-Sensing Band** wearable device.

## Features

- **BLE Connection** — Scan, connect, and communicate with MS200 via Nordic UART Service (NUS) using `flutter_blue_plus`
- **Real-Time Dashboard** — Heart rate, temperature, humidity, heat index, GPS, battery, and PPI chart
- **Fall Detection** — Real-time (ACK 0x6A byte 13) and iBeacon (Minor DataNo=15) fall detection with full-screen alert overlay, vibration, and notification
- **Device Configuration** — Read/write user profile (CMD 0x21/0x22), system params (CMD 0x2D/0x2E), clock sync (CMD 0x07)
- **Cloud Sync** — Real-time upload, batch sync, configurable API endpoint with retry logic
- **Background Service** — Android foreground service with persistent BLE connection, hybrid auto-reconnect, boot receiver
- **GPS Fallback** — Phone location via `geolocator` when MS200 GNSS is unavailable
- **Localization** — English and Japanese

## Architecture

- **State Management**: Riverpod
- **BLE**: flutter_blue_plus
- **Local Database**: drift (SQLite)
- **HTTP Client**: dio
- **Navigation**: go_router (2-tab shell: Home, Settings)
- **Background**: flutter_background_service

## Project Structure

```
lib/
  main.dart                   # Entry point
  app.dart                    # MaterialApp + GoRouter + localization
  core/                       # Constants, theme, utils
  data/
    ble/                      # BleManager, NusProtocol, BeaconScanner
    local/                    # drift database + tables
    remote/                   # dio ApiService, CloudUploader
    location/                 # Phone GPS fallback
    preferences/              # SharedPreferences wrapper
    repository/               # Sensing, FallEvent, Device repositories
  domain/model/               # SensingData, FallEvent, DeviceConfig, ConnectionState
  presentation/
    home/                     # Real-time dashboard + widgets
    settings/                 # Unified settings screen + widget sections
    scan/                     # BLE scan screen
    common/                   # ConnectionStatusChip, SensingFab
  service/                    # Background service, fall detection service
  providers/                  # Riverpod providers
  l10n/                       # ARB localization files (en, ja)
```

## Getting Started

```bash
# Clone and navigate
cd ms200_companion

# Get dependencies
flutter pub get

# Generate drift database code
dart run build_runner build --delete-conflicting-outputs

# Generate localization
flutter gen-l10n

# Run
flutter run
```

## Permissions

### Android
- `BLUETOOTH_SCAN`, `BLUETOOTH_CONNECT`, `ACCESS_FINE_LOCATION`
- `ACCESS_BACKGROUND_LOCATION` (API 29+)
- `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_CONNECTED_DEVICE`, `FOREGROUND_SERVICE_LOCATION`
- `POST_NOTIFICATIONS`, `RECEIVE_BOOT_COMPLETED`

### iOS
- `NSBluetoothAlwaysUsageDescription`
- `NSLocationAlwaysAndWhenInUseUsageDescription`
- `UIBackgroundModes`: bluetooth-central, location, fetch, processing

## REST API

- **Base URL**: configurable (default `https://cms.k-fis.com/`)
- **Auth**: `Authorization: Bearer {api_key}`
- **POST** `rawdata/sensor_data_raw` — single record or fall event
- **POST** `api/v1/sensing-batch` — batch upload

## BLE Protocol

Communication with MS200 uses the Nordic UART Service (NUS) with custom CMD/ACK framing:
- CMD: `[0x7E][LenLo][LenHi][CmdNo][Data...][CsLo][CsHi]`
- ACK: `[0x7D][LenLo][LenHi][AckNo][Data...][CsLo][CsHi]`

Key commands: 0x07 (clock), 0x0C (serial), 0x21/0x22 (user params), 0x28/0x29 (sensing), 0x2A (data stream), 0x2D/0x2E (system params).
