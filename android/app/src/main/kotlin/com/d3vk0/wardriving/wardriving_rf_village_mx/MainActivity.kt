package com.d3vk0.wardriving.wardriving_rf_village_mx

import com.d3vk0.wardriving.wardriving_rf_village_mx.scanners.TelephonyScanner
import com.d3vk0.wardriving.wardriving_rf_village_mx.scanners.WifiScanner
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
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
                    "telephony.getCellInfo" -> result.success(telephonyScanner.getCellInfo())
                    else -> result.notImplemented()
                }
            } catch (e: Exception) {
                result.error("SCAN_ERROR", e.message, null)
            }
        }
    }

    companion object {
        private const val CHANNEL = "com.d3vk0.wardriving/rf_scanners"
    }
}
