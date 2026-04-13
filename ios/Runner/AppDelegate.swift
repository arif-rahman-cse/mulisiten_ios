import Flutter
import UIKit
import CoreLocation
import CoreBluetooth

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {

    private var locationManager: CLLocationManager?
    private var centralManager: CBCentralManager?
    private var methodChannel: FlutterMethodChannel?
    private var pendingBackgroundEvents: [[String: Any]] = []

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        if launchOptions?[.location] != nil {
            pendingBackgroundEvents.append(["trigger": "significantLocationChange"])
        }

        // Significant Location Changes: survives swipe-kill.
        // iOS relaunches the app when the user moves ~500m.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.startMonitoringSignificantLocationChanges()

        // Core Bluetooth State Restoration: may relaunch app after termination
        // when a BLE event occurs for a previously-connected peripheral.
        centralManager = CBCentralManager(
            delegate: self,
            queue: nil,
            options: [CBCentralManagerOptionRestoreIdentifierKey: "ms200-central"]
        )

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
        GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

        guard let registrar = engineBridge.pluginRegistry.registrar(
            forPlugin: "MS200BackgroundPlugin"
        ) else { return }

        methodChannel = FlutterMethodChannel(
            name: "com.ms200_companion/background",
            binaryMessenger: registrar.messenger()
        )

        for event in pendingBackgroundEvents {
            methodChannel?.invokeMethod("onBackgroundLaunch", arguments: event)
        }
        pendingBackgroundEvents.removeAll()
    }

    // MARK: - Silent Push Notifications

    /*
    override func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        let event: [String: Any] = ["trigger": "silentPush"]
        if let channel = methodChannel {
            channel.invokeMethod("onBackgroundLaunch", arguments: event)
        } else {
            pendingBackgroundEvents.append(event)
        }

        // Give Dart up to 25 seconds to sync, then report to iOS
        DispatchQueue.main.asyncAfter(deadline: .now() + 25) {
            completionHandler(.newData)
        }
    }
    */
}

// MARK: - CLLocationManagerDelegate

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        let event: [String: Any] = [
            "trigger": "significantLocationChange",
            "latitude": location.coordinate.latitude,
            "longitude": location.coordinate.longitude,
        ]
        if let channel = methodChannel {
            channel.invokeMethod("onBackgroundLaunch", arguments: event)
        } else {
            pendingBackgroundEvents.append(event)
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {}
}

// MARK: - CBCentralManagerDelegate

extension AppDelegate: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // Required delegate method. BLE state is handled by flutter_blue_plus.
    }

    func centralManager(
        _ central: CBCentralManager,
        willRestoreState dict: [String: Any]
    ) {
        let event: [String: Any] = ["trigger": "bluetoothRestoration"]
        if let channel = methodChannel {
            channel.invokeMethod("onBackgroundLaunch", arguments: event)
        } else {
            pendingBackgroundEvents.append(event)
        }
    }
}
