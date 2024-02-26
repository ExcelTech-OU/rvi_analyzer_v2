import 'package:flutter/foundation.dart';

class PlantResponse {
  final String status;
  final String statusDescription;
  final List<Plant> plants;

  PlantResponse({
    required this.status,
    required this.statusDescription,
    required this.plants,
  });

  factory PlantResponse.fromJson(Map<String, dynamic> json) {
    final plants = (json['plants'] as List)
        .map((plantJson) => Plant.fromJson(plantJson))
        .toList();

    return PlantResponse(
      status: json['status'],
      statusDescription: json['statusDescription'],
      plants: plants,
    );
  }
}

class Plant {
  final String id;
  final String name;
  final String createdBy;
  final DateTime createdDateTime;
  final DateTime lastUpdatedDateTime;

  Plant({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdDateTime,
    required this.lastUpdatedDateTime,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['_id'],
      name: json['name'],
      createdBy: json['createdBy'],
      createdDateTime: DateTime.parse(json['createdDateTime']),
      lastUpdatedDateTime: DateTime.parse(json['lastUpdatedDateTime']),
    );
  }
}
