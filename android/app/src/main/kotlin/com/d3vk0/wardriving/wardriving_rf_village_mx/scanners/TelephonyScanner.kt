package com.d3vk0.wardriving.wardriving_rf_village_mx.scanners

import android.annotation.SuppressLint
import android.content.Context
import android.os.Build
import android.telephony.CellInfo
import android.telephony.CellInfoLte
import android.telephony.TelephonyManager
import java.util.concurrent.CountDownLatch
import java.util.concurrent.Executor
import java.util.concurrent.TimeUnit

class TelephonyScanner(
    context: Context,
    private val mapper: TelephonyMapper = TelephonyMapper(),
) {
    private val telephonyManager =
        context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

    @SuppressLint("MissingPermission")
    fun getCellInfo(): List<Map<String, Any?>> {
        val direct = runCatching { telephonyManager.allCellInfo.orEmpty() }.getOrDefault(emptyList())
        val cellInfo = if (direct.isNotEmpty()) direct else requestCellInfoUpdate()
        val operator = runCatching { telephonyManager.networkOperatorName }.getOrNull()
        return cellInfo.filterIsInstance<CellInfoLte>().map { mapper.mapLte(it, operator) }
    }

    @SuppressLint("MissingPermission")
    private fun requestCellInfoUpdate(): List<CellInfo> {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) return emptyList()
        val latch = CountDownLatch(1)
        var result: List<CellInfo> = emptyList()
        val callback = object : TelephonyManager.CellInfoCallback() {
            override fun onCellInfo(cellInfo: MutableList<CellInfo>) {
                result = cellInfo
                latch.countDown()
            }

            override fun onError(errorCode: Int, detail: Throwable?) {
                latch.countDown()
            }
        }
        runCatching {
            telephonyManager.requestCellInfoUpdate(Executor { it.run() }, callback)
        }.onFailure {
            latch.countDown()
        }
        latch.await(800, TimeUnit.MILLISECONDS)
        return result
    }
}
