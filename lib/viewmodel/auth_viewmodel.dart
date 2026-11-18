import '../model/user_model.dart';
import '../repository/auth_repository.dart';

class AuthViewModel {
  final AuthRepository _authRepository = AuthRepository();
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future<void> login(String email, String password) async {
    _currentUser = await _authRepository.login(email, password);
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _currentUser = null;
  }
}
