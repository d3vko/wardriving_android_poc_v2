package com.d3vk0.wardriving.wardriving_rf_village_mx.scanners

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.wifi.WifiManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel

class WifiScanner(private val context: Context) {
    private val wifiManager: WifiManager =
        context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
    private val mainHandler = Handler(Looper.getMainLooper())
    private var wifiLock: WifiManager.WifiLock? = null
    private var receiver: BroadcastReceiver? = null
    private var events: EventChannel.EventSink? = null
    @Volatile private var scanInFlight = false

    fun setEventSink(sink: EventChannel.EventSink?) {
        events = sink
    }

    fun setActive(active: Boolean) {
        if (active) {
            acquireLock()
            registerReceiver()
        } else {
            unregisterReceiver()
            releaseLock()
            scanInFlight = false
        }
    }

    fun isThrottleEnabled(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            runCatching { wifiManager.isScanThrottleEnabled }.getOrDefault(false)
        } else {
            false
        }
    }

    fun startScan(): Boolean {
        if (scanInFlight) return true
        scanInFlight = true
        val ok = runCatching { @Suppress("DEPRECATION") wifiManager.startScan() }.getOrDefault(false)
        if (!ok) scanInFlight = false
        return ok
    }

    fun getScanResults(): List<Map<String, Any?>> {
        val results = runCatching { wifiManager.scanResults }.getOrDefault(emptyList())
        val now = System.currentTimeMillis()
        return results.mapNotNull { result ->
            val bssid = result.BSSID ?: return@mapNotNull null
            mapOf(
                "bssid" to bssid,
                "ssid" to (result.SSID ?: ""),
                "capabilities" to (result.capabilities ?: ""),
                "frequency" to result.frequency,
                "level" to result.level,
                "timestamp" to now,
            )
        }
    }

    private fun acquireLock() {
        if (wifiLock?.isHeld == true) return
        val lock = wifiManager.createWifiLock(
            WifiManager.WIFI_MODE_SCAN_ONLY,
            "rfv.wifi.scan",
        )
        lock.setReferenceCounted(false)
        lock.acquire()
        wifiLock = lock
    }

    private fun releaseLock() {
        val lock = wifiLock ?: return
        if (lock.isHeld) {
            runCatching { lock.release() }
        }
        wifiLock = null
    }

    private fun registerReceiver() {
        if (receiver != null) return
        val filter = IntentFilter(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION)
        receiver = object : BroadcastReceiver() {
            override fun onReceive(ctx: Context?, intent: Intent?) {
                scanInFlight = false
                val payload = getScanResults()
                mainHandler.post {
                    events?.success(payload)
                }
            }
        }
        val app = context.applicationContext
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            app.registerReceiver(receiver, filter, Context.RECEIVER_EXPORTED)
        } else {
            @Suppress("DEPRECATION")
            app.registerReceiver(receiver, filter)
        }
    }

    private fun unregisterReceiver() {
        val current = receiver ?: return
        runCatching { context.applicationContext.unregisterReceiver(current) }
        receiver = null
    }
}
