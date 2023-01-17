import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:women_safety_app/common/constants/env.constants.dart';

class ApiResponse {
  bool isSuccess;
  String? error;
  Map<dynamic, dynamic>? data;

  ApiResponse({
    required this.isSuccess,
    this.error,
    this.data,
  });
}

class ApiService {
  final client = http.Client();
  late var _headers;

  // GET
  Future<ApiResponse> get(String path) async {
    StreamingSharedPreferences sf = await StreamingSharedPreferences.instance;
    final String authToken =
        sf.getString("authToken", defaultValue: "").getValue();
    _headers = {"Authorization": 'Bearer $authToken'};
    print('GET API Call PATH -> $path');
    print('GET API Call Headers -> $_headers');

    final url = Uri.parse(baseApiUrl + path);
    final response = await client.get(url, headers: _headers);

    print('GET API Call RESPONSE BODY-> ${response.body}');

    if (response.statusCode == StatusCode.OK) {
      return ApiResponse(
        isSuccess: true,
        data: jsonDecode(response.body),
        error: null,
      );
    }

    return ApiResponse(
      isSuccess: false,
      data: null,
      error: jsonDecode(response.body)?["message"],
    );
  }

  // POST
  Future<ApiResponse> post(String path, Object body) async {
    StreamingSharedPreferences sf = await StreamingSharedPreferences.instance;
    final String authToken =
        sf.getString("authToken", defaultValue: "").getValue();
    _headers = {"Authorization": 'Bearer $authToken'};
    print('POST API Call PATH -> $path');
    print('POST API Call BODY -> $body');
    print('POST API Call Headers -> $_headers');

    final url = Uri.parse(baseApiUrl + path);
    final response = await client.post(url, body: body, headers: _headers);

    print('POST API Call RESPONSE BODY -> ${response.body}');

    if (response.statusCode == StatusCode.OK ||
        response.statusCode == StatusCode.CREATED) {
      return ApiResponse(
        isSuccess: true,
        data: jsonDecode(response.body),
        error: null,
      );
    }

    return ApiResponse(
      isSuccess: false,
      data: null,
      error: jsonDecode(response.body)?["message"],
    );
  }

  // GET
  Future<ApiResponse> delete(String path) async {
    StreamingSharedPreferences sf = await StreamingSharedPreferences.instance;
    final String authToken =
        sf.getString("authToken", defaultValue: "").getValue();
    _headers = {"Authorization": 'Bearer $authToken'};
    print('DELETE API Call PATH -> $path');
    print('DELETE API Call Headers -> $_headers');

    final url = Uri.parse(baseApiUrl + path);
    final response = await client.delete(url, headers: _headers);

    if (response.statusCode == StatusCode.NO_CONTENT) {
      return ApiResponse(
        isSuccess: true,
        data: null,
        error: null,
      );
    }

    return ApiResponse(
      isSuccess: false,
      data: null,
      error: null,
    );
  }
}
