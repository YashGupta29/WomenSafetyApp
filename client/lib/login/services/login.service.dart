import 'package:women_safety_app/common/services/api.service.dart';

class LoginService {
  final ApiService apiService = ApiService();

  Future<ApiResponse> loginWithEmailAndPassword(
      String email, String password) async {
    final res = await apiService.post(
      "/v1/auth/login",
      {
        "email": email,
        'password': password,
      },
    );
    return res;
  }
}
