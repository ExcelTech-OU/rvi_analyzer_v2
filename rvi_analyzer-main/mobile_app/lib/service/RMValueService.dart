import 'dart:convert';
import 'package:http/http.dart' as http;

class RMValueService {
  final String apiUrl;

  RMValueService({required this.apiUrl});

  Future<List<String>> getRMValues() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<String> rmValues =
            List<String>.from(data.map((item) => item.toString()));
        return rmValues;
      } else {
        throw Exception('Failed to load RM values');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
