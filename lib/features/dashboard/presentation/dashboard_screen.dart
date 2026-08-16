import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../../config/env.dart';
import '../../../core/models/models.dart';
import '../../scanning/domain/wardriving_repository.dart';

final mapPinsProvider = StreamProvider<List<MapPin>>((ref) {
  return ref.watch(wardrivingRepositoryProvider).observeLatestMapPins();
});

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  MapLibreMapController? _controller;
  bool _styleLoaded = false;
  final Set<String> _drawn = {};

  Future<void> _syncPins(List<MapPin> pins) async {
    final map = _controller;
    if (map == null || !_styleLoaded) return;
    for (final pin in pins.take(500)) {
      if (_drawn.contains(pin.id)) continue;
      _drawn.add(pin.id);
      final color = switch (pin.type) {
        MapPinType.wifi => const Color(0xFF00A676),
        MapPinType.ble => const Color(0xFF006D77),
        MapPinType.lte => const Color(0xFF264653),
      };
      await map.addCircle(
        CircleOptions(
          geometry: LatLng(pin.latitude, pin.longitude),
          circleRadius: 6,
          circleColor: _colorToHex(color),
          circleOpacity: 0.85,
        ),
      );
    }
    if (pins.isNotEmpty) {
      final first = pins.first;
      await map.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(first.latitude, first.longitude),
          14,
        ),
      );
    }
  }

  String _colorToHex(Color c) {
    final r = (c.r * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final g = (c.g * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final b = (c.b * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    return '#$r$g$b';
  }

  @override
  Widget build(BuildContext context) {
    final pinsAsync = ref.watch(mapPinsProvider);
    ref.listen(mapPinsProvider, (_, next) {
      next.whenData(_syncPins);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          pinsAsync.when(
            data: (pins) => Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text('${pins.length} pines'),
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: MapLibreMap(
        styleString: Env.mapLibreStyleUrl,
        initialCameraPosition: const CameraPosition(
          target: LatLng(19.4326, -99.1332),
          zoom: 11,
        ),
        onMapCreated: (controller) {
          _controller = controller;
        },
        onStyleLoadedCallback: () async {
          _styleLoaded = true;
          final pins = ref.read(mapPinsProvider).valueOrNull;
          if (pins != null) await _syncPins(pins);
        },
        myLocationEnabled: true,
      ),
    );
  }
}
