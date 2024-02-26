import 'package:flutter/foundation.dart';

class MaterialResponse {
  final String status;
  final String statusDescription;
  final List<Material> materials;

  MaterialResponse({
    required this.status,
    required this.statusDescription,
    required this.materials,
  });

  factory MaterialResponse.fromJson(Map<String, dynamic> json) {
    final List<Material> materials = [];
    for (final item in json['materials']) {
      materials.add(Material.fromJson(item));
    }

    return MaterialResponse(
      status: json['status'],
      statusDescription: json['statusDescription'],
      materials: materials,
    );
  }
}

class Material {
  final String id;
  final String name;
  final String plant;
  final String customer;
  final String style;
  final String createdBy;
  final DateTime createdDateTime;

  Material({
    required this.id,
    required this.name,
    required this.plant,
    required this.customer,
    required this.style,
    required this.createdBy,
    required this.createdDateTime,
  });

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      id: json['_id'],
      name: json['name'],
      plant: json['plant'],
      customer: json['customer'],
      style: json['style'],
      createdBy: json['createdBy'],
      createdDateTime: DateTime.parse(json['createdDateTime']),
    );
  }
}
