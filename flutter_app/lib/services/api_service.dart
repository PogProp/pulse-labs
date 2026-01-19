import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  static const String baseUrl = AppConstants.baseUrl;
  
  Future<List<Map<String, dynamic>>> getMarketData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${AppConstants.marketDataEndpoint}'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] == true && jsonData['data'] != null) {
          return List<Map<String, dynamic>>.from(jsonData['data']);
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load market data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching market data: $e');
    }
  }

  Future<Map<String, dynamic>> getPortfolio() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${AppConstants.portfolioEndpoint}'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] == true && jsonData['data'] != null) {
          return jsonData['data'] as Map<String, dynamic>;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load portfolio: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching portfolio: $e');
    }
  }
}
