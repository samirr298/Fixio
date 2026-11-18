import '../model/user_model.dart';

class AuthRepository {
  // Simulated authentication repository for Fixio

  Future<UserModel> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }

    return UserModel(
      id: '1',
      email: email,
      name: 'Fixio User',
    );
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
