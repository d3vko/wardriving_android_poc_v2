package com.d3vk0.wardriving.wardriving_rf_village_mx

import com.d3vk0.wardriving.wardriving_rf_village_mx.scanners.TelephonyScanner
import com.d3vk0.wardriving.wardriving_rf_village_mx.scanners.WifiScanner
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private lateinit var wifiScanner: WifiScanner
    private lateinit var telephonyScanner: TelephonyScanner

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        wifiScanner = WifiScanner(this)
        telephonyScanner = TelephonyScanner(this)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL,
        ).setMethodCallHandler { call, result ->
            try {
                when (call.method) {
                    "wifi.startScan" -> result.success(wifiScanner.startScan())
                    "wifi.getScanResults" -> result.success(wifiScanner.getScanResults())
                    "wifi.setActive" -> {
                        wifiScanner.setActive(call.arguments as? Boolean ?: false)
                        result.success(null)
                    }
                    "wifi.isThrottleEnabled" -> result.success(wifiScanner.isThrottleEnabled())
                    "telephony.getCellInfo" -> result.success(telephonyScanner.getCellInfo())
                    else -> result.notImplemented()
                }
            } catch (e: Exception) {
                result.error("SCAN_ERROR", e.message, null)
            }
        }

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            WIFI_EVENTS,
        ).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    wifiScanner.setEventSink(events)
                }

                override fun onCancel(arguments: Any?) {
                    wifiScanner.setEventSink(null)
                }
            },
        )
    }

    companion object {
        private const val CHANNEL = "com.d3vk0.wardriving/rf_scanners"
        private const val WIFI_EVENTS = "com.d3vk0.wardriving/wifi_scans"
    }
}
