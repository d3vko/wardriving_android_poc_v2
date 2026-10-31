import 'package:flutter_test/flutter_test.dart';
import 'package:wardriving_rf_village_mx/core/security/tls_pinning.dart';

void main() {
  test('pinnea solo hosts de rf-village-mx.com', () {
    expect(TlsPinning.isPinnedHost('wardriving-ctf.rf-village-mx.com'), isTrue);
    expect(TlsPinning.isPinnedHost('error-handlers.rf-village-mx.com'), isTrue);
    expect(TlsPinning.isPinnedHost('tiles.openfreemap.org'), isFalse);
  });

  test('rechaza DER vacío en host pinneado', () {
    expect(
      TlsPinning.allows(host: 'wardriving-ctf.rf-village-mx.com', der: const []),
      isFalse,
    );
  });

  test('deja pasar hosts no pinneados (mapa, etc.)', () {
    expect(
      TlsPinning.allows(host: 'demotiles.maplibre.org', der: const [1, 2, 3]),
      isTrue,
    );
  });

  test('rechaza un DER distinto al pin de hoja', () {
    expect(
      TlsPinning.allows(
        host: 'wardriving-ctf.rf-village-mx.com',
        der: List<int>.filled(32, 7),
      ),
      isFalse,
    );
  });
}
