import 'dart:convert';
import 'package:flutter/material.dart';
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
        Uri.parse('$baseUrl/api/Auth/login'),
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
      debugPrint("ERROR: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';

      final response = await http.get(
        Uri.parse('$baseUrl/api/Auth/user'),
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final result = response.body;
        final user = json.decode(result);
        await pref.setString('userName', user['name'].toString());
        await pref.setString('userDetails', result);
        return json.decode(result);
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

  Future<List<dynamic>> getProducts() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';

      final response = await http.get(
        Uri.parse('$baseUrl/api/Products/allProducts'),
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        return res;
      } else {
        throw Exception('Unable to fetch products');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> saveMasterDetails(String payload) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';
      final response = await http.post(Uri.parse('$baseUrl/api/Visits/add'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: payload);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> uploadImage(String filePath) async {
    if (filePath == '') return null;

    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';

      var req = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/api/Uploads/Image'));
      req.headers['Authorization'] = 'Bearer $token';

      var image = await http.MultipartFile.fromPath('file', filePath);
      req.files.add(image);

      final response = await req.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final res = json.decode(responseData);
        return res;
      } else {
        throw Exception('Unable to upload image');
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> scheduleVisit(String payload) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';
      final response =
          await http.post(Uri.parse('$baseUrl/api/ScheduleVisit/add'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token'
              },
              body: payload);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getSchedules(String mrId) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';
      final response = await http.get(
          Uri.parse('$baseUrl/api/ScheduleVisit/$mrId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });

      if (response.statusCode == 200) {
        final resp = json.decode(response.body);
        return resp;
      } else {
        throw Exception('Failed to fetch planned visit');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getDoctorById(String drId) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';

      final response = await http.get(
          Uri.parse('$baseUrl/api/Doctor/getDoctorById/$drId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });

      if (response.statusCode == 200) {
        final resp = json.decode(response.body);
        return resp;
      } else {
        throw Exception('Failed to fetch doctor');
      }
    } catch (e) {
      rethrow;
    }
  }
}
