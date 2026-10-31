import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/security/auth_token_store.dart';
import '../../settings/data/app_settings_store.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    api: ref.watch(apiClientProvider),
    tokenStore: ref.watch(authTokenStoreProvider),
    settingsStore: ref.watch(appSettingsStoreProvider),
  );
});

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AsyncValue<bool>>((ref) {
  return AuthStateNotifier(ref.watch(authRepositoryProvider));
});

final usernameProvider = FutureProvider<String?>((ref) async {
  final authed = ref.watch(authStateProvider).valueOrNull == true;
  if (!authed) return null;
  return ref.read(authTokenStoreProvider).readUsername();
});

class AuthRepository {
  AuthRepository({
    required this.api,
    required this.tokenStore,
    required this.settingsStore,
  });

  final ApiClient api;
  final AuthTokenStore tokenStore;
  final AppSettingsStore settingsStore;

  Future<bool> hasToken() => tokenStore.hasToken();

  Future<String> login(String identifier, String password) async {
    final response = await api.login(identifier, password);
    final token = response.access;
    if (token == null || token.isEmpty) {
      throw StateError('Login response did not contain an access token');
    }
    await tokenStore.saveSession(token: token, username: response.username);
    await settingsStore.enableUploadByDefaultForAuthenticatedUser();
    return token;
  }

  Future<String> register({
    required String username,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    final response = await api.register(
      username: username,
      email: email,
      password: password,
      passwordConfirm: passwordConfirm,
    );
    final token = response.access;
    if (token == null || token.isEmpty) {
      throw StateError('Register response did not contain an access token');
    }
    await tokenStore.saveSession(token: token, username: response.username);
    await settingsStore.enableUploadByDefaultForAuthenticatedUser();
    return token;
  }

  Future<void> recoverPassword(String identifier) =>
      api.recoverPassword(identifier);

  Future<void> importJwt(String token) async {
    final trimmed = token.trim();
    if (trimmed.isEmpty) {
      throw StateError('JWT vacío');
    }
    await tokenStore.saveSession(token: trimmed);
    await settingsStore.enableUploadByDefaultForAuthenticatedUser();
  }

  Future<void> logout() => tokenStore.clear();
}

class AuthStateNotifier extends StateNotifier<AsyncValue<bool>> {
  AuthStateNotifier(this._repo, {AsyncValue<bool>? initial})
      : super(initial ?? const AsyncValue.loading()) {
    if (initial == null) {
      _refresh();
    }
  }

  final AuthRepository _repo;

  Future<void> _refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_repo.hasToken);
  }

  Future<void> login(String identifier, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.login(identifier, password);
      return true;
    });
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.register(
        username: username,
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
      );
      return true;
    });
  }

  Future<void> importJwt(String token) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.importJwt(token);
      return true;
    });
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AsyncValue.data(false);
  }

  Future<void> refresh() => _refresh();
}
