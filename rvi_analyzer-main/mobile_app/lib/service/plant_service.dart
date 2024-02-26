import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PlantService {
  static Future<Map<String, String>> getPlants(String plants) async {
    const storage = FlutterSecureStorage();
    final String apiUrl = '';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Extract data from JSON and use it as needed
        final String plant = jsonData['plant'] ?? '';
        final String customer = jsonData['customer'] ?? '';
        final String style = jsonData['style'] ?? '';

        return {
          'plant': plant,
          'customer': customer,
          'style': style,
        };
      } else {
        // Handle error responses
        print('Failed to fetch data. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error during API call: $error');
      throw Exception('Error during API call');
    }
  }

  // Local hardcoded values for RM (for testing purposes)
  static Map<String, String> getLocalRMValues(String rm) {
    switch (rm) {
      case 'RM 1':
        return {
          'plant': 'plant1',
          'customer': 'customer1',
          'style': 'style1',
        };
      case 'RM 2':
        return {
          'plant': 'plant2',
          'customer': 'customer2',
          'style': 'style2',
        };
      case 'RM 3':
        return {
          'plant': 'plant3',
          'customer': 'customer3',
          'style': 'style3',
        };
      // Add more cases if needed
      default:
        // Default values or error handling
        return {
          'plant': '',
          'customer': '',
          'style': '',
        };
    }
  }
}
