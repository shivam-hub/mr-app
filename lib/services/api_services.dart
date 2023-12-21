import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final resp = json.decode(response.body);
        await pref.setString('token', resp['token'].toString());
        return resp;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';

      final response = await http.get(
        Uri.parse('$baseUrl/api/auth/user'),
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch user details');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getOptions({required String query}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';

      final response = await http.get(
        Uri.parse('$baseUrl/api/Doctor/search/$query'),
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        return res['doctors'];
      } else {
        throw Exception('Unable to fetch options');
      }
    } catch (e) {
      rethrow;
    }
  }
}
