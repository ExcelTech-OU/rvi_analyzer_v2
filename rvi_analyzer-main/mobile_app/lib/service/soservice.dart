import 'dart:convert';
import 'package:http/http.dart' as http;

class SOService {
  // Function to get plant, customer, and style based on SO number from API
  static Future<Map<String, String>> getRMValues(String soNumber) async {
    final String apiUrl = ''; // Replace with your API URL

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Extract data from JSON and use it as needed
        final String rm = jsonData['RM'] ?? '';

        return {
          'rm': rm,
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
  static String getLocalRMValues(String soNumber) {
    String rmValue = ''; // Initialize the variable

    switch (soNumber) {
      case 'Customer PO 1':
        rmValue = 'RM 1';
        break;
      case 'Customer PO 2':
        rmValue = 'RM 2';
        break;
      case 'Customer PO 3':
        rmValue = 'RM 3';
        break;
      // Add more cases if needed
      default:
        // Default values or error handling
        rmValue = '';
    }

    return rmValue; // Return the value
  }
}
