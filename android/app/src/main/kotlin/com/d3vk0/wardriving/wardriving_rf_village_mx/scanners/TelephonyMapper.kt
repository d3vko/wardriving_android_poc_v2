package com.d3vk0.wardriving.wardriving_rf_village_mx.scanners

import android.os.Build
import android.telephony.CellIdentityLte
import android.telephony.CellInfo
import android.telephony.CellInfoLte

class TelephonyMapper(private val bandMapper: LteBandMapper = LteBandMapper()) {
    fun mapLte(cellInfo: CellInfoLte, operatorName: String?): Map<String, Any?> {
        val identity = cellInfo.cellIdentity
        val signal = cellInfo.cellSignalStrength
        val earfcn = identity.earfcnUnavailableToNull()
        return mapOf(
            "technology" to "LTE",
            "state" to cellInfo.connectionStateForCsv(),
            "mcc" to identity.mccForCsv(),
            "mnc" to identity.mncForCsv(),
            "lac" to identity.tac.tacUnavailableToNull(),
            "cellId" to identity.ci.ciUnavailableToNull(),
            "pci" to identity.pci.unavailableToNull(),
            "earfcn" to earfcn,
            "band" to bandMapper.bandFromEarfcn(earfcn),
            "rssi" to signal.dbm.unavailableToNull(),
            "rsrp" to signal.rsrp.unavailableToNull(),
            "rsrq" to signal.rsrq.unavailableToNull(),
            "sinr" to signal.rssnr.unavailableToNull(),
            "operator" to (operatorName ?: ""),
            // Wall clock only: CellInfo.timestampMillis (API 30+) is ms since boot.
            "timestamp" to System.currentTimeMillis(),
            "rawPayload" to "earfcn=$earfcn;timingAdvance=${signal.timingAdvance.unavailableToNull()}",
        )
    }

    private fun CellInfo.connectionStateForCsv(): String {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            cellConnectionStatus.toString()
        } else {
            if (isRegistered) "1" else "0"
        }
    }

    private fun CellIdentityLte.mccForCsv(): String? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            mccString
        } else {
            mcc.unavailableToNull()?.toString()
        }
    }

    private fun CellIdentityLte.mncForCsv(): String? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            mncString
        } else {
            mnc.unavailableToNull()?.toString()
        }
    }

    private fun CellIdentityLte.earfcnUnavailableToNull(): Int? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            earfcn.unavailableToNull()
        } else {
            null
        }
    }

    private fun Int.unavailableToNull(): Int? {
        return if (this == CellInfo.UNAVAILABLE || this == Int.MAX_VALUE || this == Int.MIN_VALUE) {
            null
        } else {
            this
        }
    }

    /** TAC is 16-bit; 0xFFFF is the "all ones" unavailable sentinel. */
    private fun Int.tacUnavailableToNull(): Int? {
        return if (this == TAC_UNAVAILABLE_SENTINEL) null else unavailableToNull()
    }

    /** LTE CI is 28-bit; 0xFFFFFFF is the "all ones" unavailable sentinel. */
    private fun Int.ciUnavailableToNull(): Int? {
        return if (this == CI_UNAVAILABLE_SENTINEL) null else unavailableToNull()
    }

    companion object {
        private const val TAC_UNAVAILABLE_SENTINEL = 65535
        private const val CI_UNAVAILABLE_SENTINEL = 268435455
    }
}
