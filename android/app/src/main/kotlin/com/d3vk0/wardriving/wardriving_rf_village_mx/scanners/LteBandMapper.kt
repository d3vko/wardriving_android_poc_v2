package com.d3vk0.wardriving.wardriving_rf_village_mx.scanners

class LteBandMapper {
    fun bandFromEarfcn(earfcn: Int?): String? = specForEarfcn(earfcn)?.band

    fun downlinkMhzFromEarfcn(earfcn: Int?): Double? {
        val value = earfcn ?: return null
        val spec = specForEarfcn(value) ?: return null
        return spec.downlinkLowMhz + 0.1 * (value - spec.downlinkOffset)
    }

    fun uplinkMhzFromEarfcn(earfcn: Int?): Double? {
        val value = earfcn ?: return null
        val spec = specForEarfcn(value) ?: return null
        return spec.uplinkLowMhz + 0.1 * (value - spec.downlinkOffset)
    }

    private fun specForEarfcn(earfcn: Int?): BandSpec? {
        val value = earfcn ?: return null
        return BAND_SPECS.firstOrNull { value in it.downlinkRange }
    }

    private data class BandSpec(
        val band: String,
        val downlinkRange: IntRange,
        val downlinkOffset: Int,
        val downlinkLowMhz: Double,
        val uplinkLowMhz: Double,
    )

    companion object {
        private val BAND_SPECS = listOf(
            BandSpec("1", 0..599, 0, 2110.0, 1920.0),
            BandSpec("2", 600..1199, 600, 1930.0, 1850.0),
            BandSpec("3", 1200..1949, 1200, 1805.0, 1710.0),
            BandSpec("4", 1950..2399, 1950, 2110.0, 1710.0),
            BandSpec("5", 2400..2649, 2400, 869.0, 824.0),
            BandSpec("7", 2750..3449, 2750, 2620.0, 2500.0),
            BandSpec("8", 3450..3799, 3450, 925.0, 880.0),
            BandSpec("20", 6150..6449, 6150, 791.0, 832.0),
            BandSpec("28", 9210..9659, 9210, 758.0, 703.0),
        )
    }
}
