import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wisata_app/base_url.dart';
import 'package:wisata_app/helper/session_manager.dart';
import 'package:wisata_app/models/login_response.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(BaseURL.urlLogin),
      body: {'email': email, 'password': password},
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final LoginResponse data = LoginResponse.fromJson(responseData);
      print(data.data.name);
      SessionManager.saveData(
          data.accessToken, data.data.name, data.data.email);
      return {'success': true, 'message': 'Login berhasil'};
    } else {
      final Map<String, dynamic> responseFail = json.decode(response.body);
      final LoginFail dataFail = LoginFail.fromJson(responseFail);
      // print('status: ${dataFail.message}');
      return {'success': false, 'message': dataFail.message.toString()};
    }
  }

  Future<Map<String, dynamic>> logout() async {
    final accessToken = await SessionManager.getToken();
    final response = await http.post(
      Uri.parse(BaseURL.urlLogout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      await SessionManager.clearUserData();
      return {'success': true, 'message': 'Logout berhasil'};
    } else {
      return {'success': false, 'message': 'Logout gagal'};
    }
  }

  Future<Map<String, dynamic>> register(String email, String password,
      String confirmPassword, String name) async {
    final response = await http.post(
      Uri.parse(BaseURL.urlRegister),
      body: {
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
        'name': name,
      },
    );
    final Map<String, dynamic> data = json.decode(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return {'success': true, 'message': 'Register berhasil'};
    } else {
      return {'success': false, 'message': data['message']};
    }
  }
}
