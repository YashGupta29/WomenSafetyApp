import 'package:women_safety_app/common/services/api.service.dart';

class SignupService {
  final ApiService apiService = ApiService();

  Future<ApiResponse> signupWithEmailAndPassword(
      String email, String password) async {
    final res = await apiService.post(
      "/v1/auth/register",
      {
        "name": email.split('@')[0],
        "email": email,
        'password': password,
      },
    );
    return res;
  }
}
