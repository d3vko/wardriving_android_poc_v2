package com.d3vk0.wardriving.wardriving_rf_village_mx.scanners

import android.content.Context
import android.net.wifi.WifiManager

class WifiScanner(private val context: Context) {
    private val wifiManager: WifiManager =
        context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager

    fun startScan(): Boolean {
        return runCatching { @Suppress("DEPRECATION") wifiManager.startScan() }.getOrDefault(false)
    }

    fun getScanResults(): List<Map<String, Any?>> {
        val results = runCatching { wifiManager.scanResults }.getOrDefault(emptyList())
        return results.mapNotNull { result ->
            val bssid = result.BSSID ?: return@mapNotNull null
            mapOf(
                "bssid" to bssid,
                "ssid" to (result.SSID ?: ""),
                "capabilities" to (result.capabilities ?: ""),
                "frequency" to result.frequency,
                "level" to result.level,
                "timestamp" to System.currentTimeMillis(),
            )
        }
    }
}
