import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wardriving_rf_village_mx/app.dart';
import 'package:wardriving_rf_village_mx/core/models/models.dart';
import 'package:wardriving_rf_village_mx/core/network/api_client.dart';
import 'package:wardriving_rf_village_mx/core/security/auth_token_store.dart';
import 'package:wardriving_rf_village_mx/features/auth/domain/auth_repository.dart';
import 'package:wardriving_rf_village_mx/features/settings/data/app_settings_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    dotenv.loadFromString(envString: '''
API_BASE_URL=https://example.com/
APP_ACCENT_COLOR=#00A676
MAPLIBRE_STYLE_URL=https://demotiles.maplibre.org/style.json
''');
  });

  testWidgets('App muestra Live sin JWT', (tester) async {
    final prefs = await SharedPreferences.getInstance();
    final settings = AppSettingsStore(prefs);
    final tokens = AuthTokenStore();
    final api = ApiClient(
      config: const ApiConfig(
        baseUrl: 'https://example.com/',
        loginPath: 'auth/login/',
        registerPath: 'auth/register/',
        passwordRecoveryPath: 'auth/password/reset/',
        uploadPath: 'files-uploaded/',
        wifiBleUploadType: 'wifi_ble_android',
        lteUploadType: 'lte_android',
      ),
      tokenStore: tokens,
    );
    final repo = AuthRepository(
      api: api,
      tokenStore: tokens,
      settingsStore: settings,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          authStateProvider.overrideWith(
            (ref) => AuthStateNotifier(
              repo,
              initial: const AsyncValue.data(false),
            ),
          ),
        ],
        child: const WardrivingApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Pecera'), findsWidgets);
    expect(find.text('Pecera del WiFi'), findsWidgets);
    expect(find.text('Login'), findsWidgets);
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('by d3v.k0'), findsWidgets);
    expect(find.textContaining('BugCON 2026'), findsWidgets);
  });
}
