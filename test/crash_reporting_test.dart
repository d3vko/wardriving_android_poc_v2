import 'package:flutter_test/flutter_test.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wardriving_rf_village_mx/core/observability/crash_reporting.dart';

void main() {
  test('redacta password y JWT, no el resto', () {
    final cleaned = redactSensitiveMap({
      'username': 'operator',
      'password': 'secret',
      'Authorization': 'Bearer abc.def',
      'nested': {'access': 'jwt-value', 'ok': true},
    });

    expect(cleaned['username'], 'operator');
    expect(cleaned['password'], '[redacted]');
    expect(cleaned['Authorization'], '[redacted]');
    expect((cleaned['nested'] as Map)['access'], '[redacted]');
    expect((cleaned['nested'] as Map)['ok'], true);
  });

  test('redacta coordenadas GPS sintéticas', () {
    final cleaned = redactSensitiveMap({
      'ssid': 'lab-ap',
      'latitude': 1.2345678,
      'longitude': -9.8765432,
      'accuracyMeters': 12.0,
    });

    expect(cleaned['ssid'], 'lab-ap');
    expect(cleaned['latitude'], '[redacted]');
    expect(cleaned['longitude'], '[redacted]');
    expect(cleaned['accuracyMeters'], '[redacted]');
  });

  test('scrubSentryEvent quita user y headers de auth', () {
    final event = SentryEvent(
      user: SentryUser(id: 'u1', email: 'ops@example.com'),
      request: SentryRequest(
        url: 'https://example.com/auth/login/',
        headers: {'Authorization': 'Bearer abc'},
        data: {'password': 'secret', 'username': 'operator'},
      ),
      breadcrumbs: [
        Breadcrumb(
          message: 'login',
          data: {'lat': 1.2345678, 'path': '/live'},
        ),
      ],
    );

    final scrubbed = scrubSentryEvent(event, Hint());
    expect(scrubbed, isNotNull);
    expect(scrubbed!.user, isNull);
    expect(scrubbed.request!.headers['Authorization'], '[redacted]');
    expect((scrubbed.request!.data as Map)['password'], '[redacted]');
    expect((scrubbed.request!.data as Map)['username'], 'operator');
    expect(scrubbed.breadcrumbs?.single.data?['lat'], '[redacted]');
    expect(scrubbed.breadcrumbs?.single.data?['path'], '/live');
  });
}
