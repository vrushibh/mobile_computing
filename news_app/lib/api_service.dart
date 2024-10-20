// lib/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://newsapi.org/v2';
  final String _apiKey = 'f22dbec2422348a18daa44c4ffc2ef39'; // Replace with your API key

  Future<List<dynamic>> fetchNews(String category) async {
    final response = await http.get(Uri.parse('$_baseUrl/top-headlines?category=$category&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
