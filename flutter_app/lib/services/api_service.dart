import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/issue_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';
  // For Android emulator, use: 'http://10.0.2.2:3000/api'
  // For iOS simulator, use: 'http://localhost:3000/api'
  // For physical device, use your computer's IP: 'http://192.168.x.x:3000/api'

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<Map<String, String>> _getHeaders({bool includeAuth = true}) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    if (includeAuth) {
      final token = await getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  // Auth APIs
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: await _getHeaders(includeAuth: false),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        await saveToken(data['token']);
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Registration failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: await _getHeaders(includeAuth: false),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await saveToken(data['token']);
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<void> logout() async {
    await removeToken();
  }

  // User APIs
  static Future<User?> getCurrentUser() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/me'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Issue APIs
  static Future<List<Issue>> getIssues({
    String? status,
    String? issueType,
    String? priority,
  }) async {
    try {
      String url = '$baseUrl/issues?';
      if (status != null) url += 'status=$status&';
      if (issueType != null) url += 'issueType=$issueType&';
      if (priority != null) url += 'priority=$priority&';

      final response = await http.get(
        Uri.parse(url),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((json) => Issue.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<DashboardStats?> getDashboardStats() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/issues/stats'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DashboardStats.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<Issue?> getIssue(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/issues/$id'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Issue.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>> createIssue({
    required String issueType,
    required String description,
    required Location location,
    required List<String> photoPaths,
  }) async {
    try {
      // For file upload, you would use multipart request
      // This is a simplified version - you'll need to implement multipart upload
      final response = await http.post(
        Uri.parse('$baseUrl/issues'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'issueType': issueType,
          'description': description,
          'location': location.toJson(),
          'photos': photoPaths, // These should be URLs after upload
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {'success': true, 'data': Issue.fromJson(data)};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Failed to create issue'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> updateIssue({
    required String id,
    String? status,
    String? priority,
    String? resolutionNotes,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (status != null) body['status'] = status;
      if (priority != null) body['priority'] = priority;
      if (resolutionNotes != null) body['resolutionNotes'] = resolutionNotes;

      final response = await http.put(
        Uri.parse('$baseUrl/issues/$id'),
        headers: await _getHeaders(),
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {'success': true, 'data': Issue.fromJson(data)};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Failed to update issue'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<bool> deleteIssue(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/issues/$id'),
        headers: await _getHeaders(),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

