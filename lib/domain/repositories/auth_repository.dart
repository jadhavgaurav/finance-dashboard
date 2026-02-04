// TODO: user model

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> logout();
  Stream<bool> get authStateChanges;
  bool? get currentAuthStatus; // Returns null if unknown/loading
}
