package com.kodensya.ms200_companion

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val nm = getSystemService(NotificationManager::class.java)
            val channel = NotificationChannel(
                "FOREGROUND_DEFAULT",
                "MS200 background service",
                NotificationManager.IMPORTANCE_DEFAULT,
            ).apply {
                description =
                    "Keeps device connection and sensing active in the background."
                setShowBadge(false)
            }
            nm.createNotificationChannel(channel)
        }
        super.onCreate(savedInstanceState)
    }
}
