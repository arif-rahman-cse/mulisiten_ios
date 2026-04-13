# App Store Privacy Nutrition Labels — MS200 Companion

Use this reference when filling in the **App Privacy** section in App Store Connect.
Each section maps to the App Store Connect questionnaire.

---

## 1. Do you or your third-party partners collect data from this app?

**Yes**

---

## 2. Data Types Collected

### Health & Fitness

| Data Type | Collected | Linked to Identity | Used for Tracking | Purpose |
|---|---|---|---|---|
| **Health** (heart rate, body temperature, humidity, heat index, fall detection status, PPI values) | Yes | Yes | No | App Functionality |
| **Fitness** (step count, active calories burned — via Apple HealthKit) | Yes | Yes | No | App Functionality |

### Location

| Data Type | Collected | Linked to Identity | Used for Tracking | Purpose |
|---|---|---|---|---|
| **Precise Location** (phone GPS + wristband GPS coordinates) | Yes | Yes | No | App Functionality |

### Contact Info

| Data Type | Collected | Linked to Identity | Used for Tracking | Purpose |
|---|---|---|---|---|
| **Name** (user's first and last name entered in settings, sent with cloud uploads) | Yes | Yes | No | App Functionality |

### Identifiers

| Data Type | Collected | Linked to Identity | Used for Tracking | Purpose |
|---|---|---|---|---|
| **Device ID** (MS200 wristband serial/BLE address) | Yes | Yes | No | App Functionality |

### Diagnostics

| Data Type | Collected | Linked to Identity | Used for Tracking | Purpose |
|---|---|---|---|---|
| **Other Diagnostic Data** (wristband battery level) | Yes | Yes | No | App Functionality |

### Other Data

| Data Type | Collected | Linked to Identity | Used for Tracking | Purpose |
|---|---|---|---|---|
| **Other Data Types** (altitude difference, environmental temperature, humidity readings) | Yes | Yes | No | App Functionality |

---

## 3. Data Use Descriptions (for App Store Connect text fields)

### Health & Fitness Data
> Heart rate, body temperature, humidity, heat index, and fall detection data are collected from the MS200 wristband via Bluetooth to provide real-time health monitoring and safety alerts. Step count and calorie data are read from Apple HealthKit (read-only) to display daily activity summaries.

### Precise Location
> GPS coordinates are collected from the phone and/or MS200 wristband to tag health readings with location data for emergency fall detection response and health record context.

### Name
> The user's first and last name is associated with sensor data for identification purposes when data is optionally uploaded to the cloud monitoring platform.

### Device ID
> The MS200 wristband Bluetooth device identifier is used to maintain the pairing connection and associate sensor readings with the correct device.

---

## 4. Key Facts for Reviewer Notes

- **HealthKit access is READ-ONLY** — the app never writes to Apple Health.
- **HealthKit data types**: `HKQuantityTypeIdentifier.stepCount`, `HKQuantityTypeIdentifier.activeEnergyBurned`
- **HealthKit data is NOT uploaded to the cloud** — it is only displayed locally in the daily activity card.
- **Cloud upload is OFF by default** — user must explicitly enable it in Settings.
- **No advertising or analytics SDKs** are included.
- **No third-party tracking** is performed.
- **Background location** is used for fall detection emergency response and maintaining BLE connection for continuous health monitoring.
- **Background Bluetooth** is used to maintain a persistent connection with the MS200 wristband for real-time health data streaming.

---

## 5. HealthKit-Specific Compliance Checklist

- [x] App reads HealthKit data (steps, calories) — declared in `NSHealthShareUsageDescription`
- [x] App does NOT write HealthKit data — `NSHealthUpdateUsageDescription` removed
- [x] HealthKit data is never shared with third parties for advertising or marketing
- [x] HealthKit data stays on-device (not uploaded to cloud)
- [x] Privacy policy is accessible and covers HealthKit usage
- [x] `com.apple.developer.healthkit` entitlement is present
- [x] `com.apple.developer.healthkit.access` entitlement is present
- [x] HealthKit capability is enabled in Xcode Signing & Capabilities
- [x] `PrivacyInfo.xcprivacy` manifest includes Health and Fitness data declarations

---

## 6. Required Privacy Policy Disclosures

Your privacy policy (hosted URL) must disclose:
1. What health/fitness data is collected and why
2. That HealthKit data is not sold or shared for advertising
3. How sensor data (heart rate, temperature, etc.) is collected and stored
4. That location data is collected and the purpose
5. Cloud upload practices and user control
6. Data retention and deletion procedures
7. Contact information for privacy inquiries
