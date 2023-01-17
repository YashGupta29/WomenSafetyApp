import 'package:women_safety_app/common/services/api.service.dart';

class ContactsService {
  final ApiService apiService = ApiService();

  Future<ApiResponse> getContacts() async {
    final res = await apiService.get(
      "/v1/contacts/all",
    );
    return res;
  }

  Future<ApiResponse> addContact(String name, String number) async {
    final res = await apiService.post(
      "/v1/contacts",
      {
        "name": name,
        'number': number,
      },
    );
    return res;
  }

  Future<ApiResponse> deleteContact(String contactId) async {
    final res = await apiService.delete(
      '/v1/contacts/$contactId',
    );
    return res;
  }
}
