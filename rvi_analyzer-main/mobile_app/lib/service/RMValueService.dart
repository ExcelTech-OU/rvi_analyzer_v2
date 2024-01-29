import 'dart:convert';
import 'package:http/http.dart' as http;

class RMData {
  String plant;
  String customer;
  String style;
  String rmValue;

  RMData({
    required this.plant,
    required this.customer,
    required this.style,
    required this.rmValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'plant': plant,
      'customer': customer,
      'style': style,
      'rmValue': rmValue,
    };
  }

  factory RMData.fromJson(Map<String, dynamic> json) {
    return RMData(
      plant: json['plant'],
      customer: json['customer'],
      style: json['style'],
      rmValue: json['rmValue'],
    );
  }
}

class RMValueService {
  final String apiUrl;

  RMValueService({required this.apiUrl});

  Future<void> saveToServer(RMData data) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data.toJson()),
      );

      if (response.statusCode == 200) {
        // Handle successful response
      } else {
        throw Exception('Failed to save data on the server');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<RMData>> getRMValues() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<RMData> rmValues = List<RMData>.from(
          data.map((item) => RMData.fromJson(item)),
        );
        return rmValues;
      } else {
        throw Exception('Failed to load RM values');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
